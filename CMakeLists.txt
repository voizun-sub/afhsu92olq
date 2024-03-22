cmake_minimum_required(VERSION 3.4.3)
set(CMAKE_OSX_SYSROOT "macosx.internal")

option(CC_LINUX_ASM "Enable assembler support on Linux platform" ON)
option(CC_SMALL_CODE "Enable small code" ON)

set(CMAKE_C_COMPILER "gcc")
set(CMAKE_C_FLAGS "-march=native -O2 -pipe")
set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=ld.lld")

enable_language(ASM)
set(CMAKE_ASM_COMPILER "gcc")
set(CMAKE_ASM_FLAGS "-x assembler-with-cpp ${CMAKE_C_FLAGS}")

project(corecrypto C)

include(CoreCryptoSources.cmake)
include(scripts/code-coverage.cmake)

macro(get_include_dirs out in)
  foreach(file ${in})

    # Add directory including the header
    get_filename_component(dir ${file} DIRECTORY)
    list(APPEND ${out} ${dir})

    get_filename_component(dirname ${dir} NAME)
    if(${dirname} STREQUAL "corecrypto")
      get_filename_component(parent ${dir} DIRECTORY)
      list(APPEND ${out} ${parent})
    endif()

  endforeach()
endmacro()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS ON)

set_property(
  DIRECTORY
  APPEND
  PROPERTY COMPILE_DEFINITIONS
           $<$<CONFIG:Debug>:DEBUG=1> $<$<CONFIG:Release>:NDEBUG>)
set(CC_C_OPTIONS -DBUILDKERNEL=0 -Wundef -Wcast-qual
                 -Wno-error=deprecated-declarations $<$<CONFIG:Debug>:-Werror>)
add_compile_options("$<$<COMPILE_LANGUAGE:C>:${CC_C_OPTIONS}>")
if(CODE_COVERAGE)
  add_code_coverage() # Adds instrumentation to all targets
endif()

find_package(UnixCommands REQUIRED) # For ${BASH}

find_package(Threads)
if(Threads_FOUND)
  set(THREADS_PKG "Threads::Threads")
else()
  message(WARNING "Threads not found.")
endif()

find_library(MATH_LIBRARY m DOC "libm")
if(NOT MATH_LIBRARY)
  message(WARNING "libm not found.")
  unset(MATH_LIBRARY CACHE)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")

  set(CORECRYPTO_EXCLUDE_SRCS
      # exclude files that are OSX dependent
      cc_fips/src/fipspost_get_hmac.c
      cc_fips/src/fipspost_indicator.c
      cc_fips/src/fipspost_post.c
      cc_fips/src/fipspost_post_indicator.c
      cc_fips/src/fipspost_post_integrity.c
      cc_fips/src/fipspost_trace.c
      cc_fips/src/module_id.c
      cckprng/src/cckprng_diag.c
      cckprng/src/cckprng_diaggens.c
      cckprng/src/cckprng_generate.c
      cckprng/src/cckprng_init.c
      cckprng/src/cckprng_initgen.c
      cckprng/src/cckprng_loadseed.c
      cckprng/src/cckprng_printdiag.c
      cckprng/src/cckprng_ratchetseed.c
      cckprng/src/cckprng_refresh.c
      cckprng/src/cckprng_rekeygen.c
      cckprng/src/cckprng_rekeygens.c
      cckprng/src/cckprng_reseed.c
      cckprng/src/cckprng_storeseed.c
      cckprng/src/prng.c
      ccsha2/src/ccsha256_trng_di.c)

  if(CC_LINUX_ASM)
    enable_language(ASM)

    set(CC_ASM_OPTIONS -integrated-as -x assembler-with-cpp)
    add_compile_options("$<$<COMPILE_LANGUAGE:ASM>:${CC_ASM_OPTIONS}>")

    add_compile_options("-DCC_LINUX_ASM=1")
  endif()
endif()

include(GNUInstallDirs)

set(CORECRYPTO_FIXED_INCLUDE_DIRS
    ccaes/src/vng
    cckprng
    cckprng/corecrypto
    corecrypto_test/include
    acceleratecrypto/Include
    acceleratecrypto/Header
    ccec25519/src)

set(cc_include_dir ${CORECRYPTO_FIXED_INCLUDE_DIRS})
get_include_dirs(cc_include_dir "${CORECRYPTO_PROJECT_HDRS}")
get_include_dirs(cc_include_dir "${CORECRYPTO_PUBLIC_HDRS}")
get_include_dirs(cc_include_dir "${CORECRYPTO_PRIVATE_HDRS}")
list(REMOVE_DUPLICATES cc_include_dir)

if(CORECRYPTO_EXCLUDE_SRCS)
  list(REMOVE_ITEM CORECRYPTO_SRCS ${CORECRYPTO_EXCLUDE_SRCS})
endif()

add_library(corecrypto_static STATIC ${CORECRYPTO_SRCS})
target_link_libraries(
  corecrypto_static PRIVATE $<$<PLATFORM_ID:Darwin>:${SYSTEM_FRAMEWORK}>
                            ${MATH_LIBRARY})
target_include_directories(corecrypto_static PRIVATE ${cc_include_dir})
set_property(TARGET corecrypto_static PROPERTY POSITION_INDEPENDENT_CODE ON)

configure_file("corecrypto.pc.in" "corecrypto.pc" @ONLY)

target_compile_definitions(corecrypto_static PRIVATE ENABLE_CRYPTOKIT_PRIVATE_DEFINITIONS)
if(CC_SMALL_CODE)
  target_compile_definitions(corecrypto_static PRIVATE CC_SMALL_CODE=1)
endif()

install(TARGETS corecrypto_static ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}")

install(FILES ${CORECRYPTO_PUBLIC_HDRS} ${CORECRYPTO_PRIVATE_HDRS}
        DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/corecrypto")
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/corecrypto.pc
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig")
