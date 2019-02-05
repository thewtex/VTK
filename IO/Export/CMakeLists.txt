set(Module_SRCS
  vtkExporter.cxx
  vtkGLTFExporter.cxx
  vtkIVExporter.cxx
  vtkJSONDataSetWriter.cxx
  vtkJSONSceneExporter.cxx
  vtkOBJExporter.cxx
  vtkOOGLExporter.cxx
  vtkPOVExporter.cxx
  vtkRIBExporter.cxx
  vtkRIBLight.cxx
  vtkRIBProperty.cxx
  vtkSingleVTPExporter.cxx
  vtkSVGContextDevice2D.cxx
  vtkSVGExporter.cxx
  vtkVRMLExporter.cxx
  vtkX3D.cxx
  vtkX3DExporter.cxx
  vtkX3DExporterFIWriter.cxx
  vtkX3DExporterWriter.cxx
  vtkX3DExporterXMLWriter.cxx
  )
if(NOT EMSCRIPTEN)
  list(APPEND Module_SRCS vtkGL2PSExporter.cxx)
 endif()

vtk_module_library(vtkIOExport ${Module_SRCS})
include(vtkOpenGL)
vtk_opengl_link(vtkIOExport)
