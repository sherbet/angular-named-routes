describe 'namedRoutes.directives', ->
  $scope = null
  $compile = null

  beforeEach(inject (_$rootScope_, _$compile_) ->
    $scope = _$rootScope_
    $compile = _$compile_
  )

  compileLink = (markup, scope) ->
    el = $compile(markup)(scope)
    scope.$digest()
    el

  it "resolves a simple routename", ->
    markup = "<a data-named-route='product-list'>Products</a>"
    element =  compileLink markup, $scope

    expect element
      .toBeDefined()
    expect element.attr('href')
      .toBeDefined()
    expect element.attr('href')
      .toEqual "/products"


  it "should resolve a routename with args", ->
    markup = "<a data-named-route='product-detail' data-args='[16]'>Products #16</a>"
    element =  compileLink markup, $scope

    expect element
      .toBeDefined()
    expect element.attr('href')
      .toBeDefined()
    expect element.attr('href')
      .toEqual "/product/16"

  it "should resolve a routename with kwargs", ->
    markup = "<a data-named-route='product-detail' data-kwarg-id='16'>Products #16</a>"
    element =  compileLink markup, $scope

    expect element
      .toBeDefined()
    expect element.attr('href')
      .toBeDefined()
    expect element.attr('href')
      .toEqual "/product/16"

  it "should resolve a routename with many args", ->
    markup = """<a data-named-route='product-category' data-args='["fish", 34]'>Products #16</a>"""
    element =  compileLink markup, $scope

    expect element
      .toBeDefined()
    expect element.attr('href')
      .toBeDefined()
    expect element.attr('href')
      .toEqual "/products/fish/34"


  it "should resolve a routename with many kwargs", ->
    markup = """<a data-named-route='product-category' data-kwarg-tag='fish' data-kwarg-page='34'>Products tagged Fish. (page 34)</a>"""
    element =  compileLink markup, $scope

    expect element
      .toBeDefined()
    expect element.attr('href')
      .toBeDefined()
    expect element.attr('href')
      .toEqual "/products/fish/34"

  describe "optional parameters", ->
    it "should resolve a routename missing an optional arg by omitting the url section", ->
      markup = """<a data-named-route='product-category-section' data-kwarg-tag='fish' data-kwarg-section='cartoon'>Products tagged Fish. (page 34)</a>"""
      element =  compileLink markup, $scope

      expect element
        .toBeDefined()
      expect element.attr('href')
        .toBeDefined()
      expect element.attr('href')
        .toEqual "/products/fish/cartoon"

    it "should resolve a routename containing an optional arg", ->
      markup = """<a data-named-route='product-category-section' data-kwarg-tag='fish' data-kwarg-page='34' data-kwarg-section='cartoon'>Products tagged Fish. (page 34)</a>"""
      element =  compileLink markup, $scope

      expect element
        .toBeDefined()
      expect element.attr('href')
        .toBeDefined()
      expect element.attr('href')
        .toEqual "/products/fish/34/cartoon"
