# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(($) ->
  $(document).on 'click', '.delete-fields-btn', (e) ->
    tree = $('#tree-customized').fancytree('getTree')
    nodes = tree.getSelectedNodes()

    nodes.forEach (node) ->
      node.remove()

    $('.delete-fields-btn').addClass('d-none') if tree.getSelectedNodes().length == 0

    e.preventDefault()

  $(document).on 'click', '.add-new-field-btn',  (e) ->
    rootNode = $('#tree-customized').fancytree("getRootNode");

    childNode = rootNode.addChildren
      title: '<input type="text" name="settings[customized_metadata_fields][]" placeholder="New Field" class="form-control">'

    e.preventDefault()
) jQuery

$(document).on 'turbolinks:load', ->
  if location.hash != ''
    $('#nav-tab a[href="' + location.hash + '"]').tab('show')


  if $('#tree-predefined,#tree-customized').length > 0 
    # Initialize Fancytree
    $('#tree-predefined').fancytree
      extensions: [
        'glyph'
        'table'
      ]
      escapeTitles: false
      autoScroll: true
      selectMode: 2
      checkbox: false
      icon: false
      glyph:
        preset: 'awesome5'
      source: 
        url: "/settings/predefined_metadata_fields.json"
      # source: [
      #   {
      #     'title': '<input type="hidden" name="settings[predefined_metadata_fields][]" value="FieldID"><span>FieldID</span>'
      #     # 'delete': '<button class="btn btn-secondary btn-sm delete-field-btn">Delete</button>'
      #   }
      # ]
      table:
        checkboxColumnIdx: 0
        nodeColumnIdx: 1
      init: (event, data) ->
        node = $('#tree-predefined').fancytree('getRootNode')
        comparer = (index) ->
          (a, b) ->
            valA = getCellValue(a, index)
            valB = getCellValue(b, index)
            if $.isNumeric(valA) and $.isNumeric(valB) then valA - valB else valA.toString().localeCompare(valB)

        getCellValue = (row, index) ->
          $(row).children('td').eq(index).text()

        $('.sort').click ->
          $('th').removeClass('active')          
          table = $(this).parents('table').eq(0)
          rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
          $(this).toggleClass 'active'
          $(this).toggleClass 'sortDSC'         
          @asc = !@asc
          if !@asc
            rows = rows.reverse()
          i = 0
          while i < rows.length
            table.append rows[i]
            i++
          return
      renderColumns: (event, data) ->
        node = data.node
        $tdList = $(node.tr).find('>td')
        # (Index #0 is rendered by fancytree by adding the checkbox)
        # (Index #1 is rendered by fancytree)
        $tdList.eq(2).html node.data.delete
        return

  $('#tree-customized').fancytree
      extensions: [
        'glyph'
        'table'
      ]
      escapeTitles: false
      autoScroll: true
      keyboard: false
      selectMode: 2
      checkbox: true 
      icon: false
      glyph:
        preset: 'awesome5'
      source: 
        url: "/settings/customized_metadata_fields.json"
      # source: [
      #   {
      #     'title': '<input type="hidden" name="settings[customized_metadata_fields][]" value="FieldID"><span>FieldID</span>'
      #     # 'delete': '<button class="btn btn-secondary btn-sm delete-field-btn">Delete</button>'
      #   }
      # ]
      table:
        checkboxColumnIdx: 0
        nodeColumnIdx: 1
      init: (event, data) ->
        node = $('#tree-customized').fancytree('getRootNode')
        comparer = (index) ->
          (a, b) ->
            valA = getCellValue(a, index)
            valB = getCellValue(b, index)
            if $.isNumeric(valA) and $.isNumeric(valB) then valA - valB else valA.toString().localeCompare(valB)

        getCellValue = (row, index) ->
          $(row).children('td').eq(index).text()

        $('.sort').click ->
          $('th').removeClass('active')          
          table = $(this).parents('table').eq(0)
          rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
          $(this).toggleClass 'active'
          $(this).toggleClass 'sortDSC'         
          @asc = !@asc
          if !@asc
            rows = rows.reverse()
          i = 0
          while i < rows.length
            table.append rows[i]
            i++
          return
      renderColumns: (event, data) ->
        console.log event, data
        node = data.node
        $tdList = $(node.tr).find('>td')
        # (Index #0 is rendered by fancytree by adding the checkbox)
        # (Index #1 is rendered by fancytree)
        $tdList.eq(2).html node.data.delete
        return
      select: (event, data) ->
        console.log event, data, "current state=" + data.node.isSelected()
        selectedNodes = data.tree.getSelectedNodes()

        if selectedNodes.length > 0
          $('.delete-fields-btn').removeClass('d-none')
        else
          $('.delete-fields-btn').addClass('d-none')
    return

  $('#metadataDataTable').DataTable({
  columnDefs: [
    { targets: 'no-sort', orderable: false }
  ]   
  })
  return