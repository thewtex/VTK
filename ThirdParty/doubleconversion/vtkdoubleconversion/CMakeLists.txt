cmake_minimum_required(VERSION 3.3)
project(doubleconversion)

if("${DOUBLE_CONVERSION_CORRECT_DOUBLE_OPERATIONS}" MATCHES "^${DOUBLE_CONVERSION_CORRECT_DOUBLE_OPERATION}$")
  set(_test_source "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/double-correction-needed.cc")
  file(WRITE ${_test_source} "
  #include <stdio.h>
  int main(int, char **)
  {
    const double correct = 89255.0/1e22;
    printf(\"89255.0/1e22 = %g\", correct);
    if( correct != 89255e-22 )
      {
      // correction required
      return 0;
      }
    return 1;
  }")
  try_run(DOUBLE_CONVERSION_CORRECT_DOUBLE_OPERATIONS DOUBLE_CORRECT_NEEDED_COMPILED
    ${CMAKE_CURRENT_BINARY_DIR} ${_test_source}
    RUN_OUTPUT_VARIABLE _double_correction_out)
  message(STATUS "Double correction test returned: ${_double_correction_out}")
endif()
configure_file(double-conversion/double-conversion-configure.h.in double-conversion-configure.h)

set(headers
  double-conversion/bignum.h
  double-conversion/cached-powers.h
  double-conversion/diy-fp.h
  double-conversion/double-conversion.h
  double-conversion/fast-dtoa.h
  double-conversion/fixed-dtoa.h
  double-conversion/ieee.h
  double-conversion/strtod.h
  double-conversion/utils.h)

set(sources
  double-conversion/bignum.cc
  double-conversion/bignum-dtoa.cc
  double-conversion/cached-powers.cc
  double-conversion/diy-fp.cc
  double-conversion/double-conversion.cc
  double-conversion/fast-dtoa.cc
  double-conversion/fixed-dtoa.cc
  double-conversion/strtod.cc)

vtk_add_library(vtkdoubleconversion
  ${sources}
  ${headers})

target_include_directories(
  vtkdoubleconversion
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<INSTALL_INTERFACE:${VTK_INSTALL_INCLUDE_DIR}>
)

include(GenerateExportHeader)
generate_export_header(vtkdoubleconversion
  EXPORT_MACRO_NAME VTKDOUBLECONVERSION_EXPORT
  EXPORT_FILE_NAME vtkdoubleconversion_export.h)

if (NOT VTK_INSTALL_NO_DEVELOPMENT)
  install(
    DIRECTORY double-conversion/
    DESTINATION "${VTK_INSTALL_INCLUDE_DIR}/vtkdoubleconversion/double-conversion"
    FILES_MATCHING PATTERN "*.h")
  install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/vtkdoubleconversion_export.h
    DESTINATION "${VTK_INSTALL_INCLUDE_DIR}/vtkdoubleconversion/double-conversion")
endif()
