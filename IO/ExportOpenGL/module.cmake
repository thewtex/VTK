if(ANDROID OR APPLE_IOS) # No GL2PS on mobile
  return()
endif()
vtk_module(vtkIOExportOpenGL
  IMPLEMENTS
    vtkIOExport
  BACKEND
    OpenGL
  IMPLEMENTATION_REQUIRED_BY_BACKEND
  TEST_DEPENDS
    vtkTestingRendering
    vtkViewsContext2D
  DEPENDS
    vtkCommonCore
    vtkIOExport
    vtkRendering${VTK_RENDERING_BACKEND}
  PRIVATE_DEPENDS
    vtkCommonDataModel
    vtkCommonMath
    vtkCommonTransforms
    vtkFiltersGeneral
    vtkImagingCore
    vtkRenderingAnnotation
    vtkRenderingContext2D
    vtkRenderingCore
    vtkRenderingFreeType
    vtkRenderingGL2PS
    vtkRenderingLabel
    vtkgl2ps
)