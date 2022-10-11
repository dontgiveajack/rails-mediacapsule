# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  if $('#tree').length > 0 
    # Initialize Fancytree

    ajax_url = ''
    if $('#tree').hasClass('is-favourites') 
      ajax_url = "/nodes.json?favourites=true" 
    else 
      ajax_url = "/nodes.json?parent_id=#{$('#tree').data('parentId')}"

    $('#tree').fancytree
      extensions: [
        'glyph'
        'table'
        'dnd5'
      ]
      renderNode: (event, data) ->
        # need to ability escape HTML
        return
      escapeTitles: false
      autoScroll: true
      selectMode: 2
      checkbox: true
      dnd5:
        preventVoidMoves: true
        preventRecursiveMoves: true
        autoExpandMS: 400
        multiSource: true
        dragStart: (node, data) ->
          return true
        dragEnter: (node, data) ->
          ['over']
          # return true        
        dragDrop: (node, data) ->
          return false if node.data.resource_type == 'tenant_media_item'

          console.log(data)
          # console.log data.otherNode.data.resource_type
          console.log(data.hitMode)

          $.each data.otherNodeList, (index, otherNode) ->
            is_last_node = false

            if data.otherNodeList.length == index + 1
              is_last_node = true

            otherNode.moveTo node, data.hitMode    

            submitData = {}
            submitData[otherNode.data.resource_type] = {}

            if otherNode.data.resource_type == 'tenant_folder'
              submitData[otherNode.data.resource_type].parent_id = node.data.resource_id
            else
              submitData[otherNode.data.resource_type].folder_id = node.data.resource_id

            submitData['is_last_node'] = is_last_node

            $.ajax
              url: otherNode.data.resource_url
              type: 'PUT'
              data: submitData
              # processData: false
              # contentType: false
              dataType: 'script'
  
        dragDrag: (node, data) ->
          # console.log(node, data)
          return true
        dragEnd: (node, data) ->
          return true   
      glyph:
        preset: 'awesome5'
        map:
          folder: 'fas fa-folder'
          folderOpen: 'fas fa-folder-open'
      source: 
        url: ajax_url
      # source: [
      #   {
      #     'title': 'Moto G'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Motorola'
      #     'updated': 2014
      #   }
      #   {
      #     'title': 'Galaxy S8'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Samsung'
      #     'updated': 2016
      #   }
      #   {
      #     'title': 'iPhone SE'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Apple'
      #     'updated': 2016
      #   }
      #   {
      #     'title': 'G6'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'LG'
      #     'updated': 2017
      #     'qty': 951
      #   }
      #   {
      #     'title': 'Lumia'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Microsoft'
      #     'updated': 2014
      #   }
      #   {
      #     'title': 'Xperia'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Sony'
      #     'updated': 2014
      #   }
      #   {
      #     'title': '3210'
      #     'folder': true
      #     'online': '<i class="fas fa-circle"></i>'
      #     'archived': false
      #     'size': '123kb'
      #     'addedBy': 'Nokia'
      #     'updated': 1999
      #   }
      # ]
      table:
        checkboxColumnIdx: 0
        nodeColumnIdx: 2
      init: (event, data) ->
        node = $('#tree').fancytree('getRootNode')
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
      select: (event, data) ->
        #need to keep toggle for multiple selected folders
        selNodes = data.tree.getSelectedNodes()
        console.log selNodes
        if selNodes.length > 0
          $('#folder-actions').addClass 'd-block'
        else
          $('#folder-actions').removeClass 'd-block'
          $('#folder-actions a.move').attr 'href', '#'

        if selNodes.length == 1
          $('#folder-actions a.move').attr 'href', data.node.data.resource_move_url
        else
          if selNodes.length > 1
            move_url = '/nodes/move?'

            $.each selNodes, (index, selectedNode) ->
              if index == 0
                if selectedNode.data.resource_type == 'tenant_folder'
                  move_url = "#{move_url}folder_ids[]=#{selectedNode.data.resource_id}"
                else
                  move_url = "#{move_url}media_item_ids[]=#{selectedNode.data.resource_id}"
              else
                if selectedNode.data.resource_type == 'tenant_folder'
                  move_url = "#{move_url}&folder_ids[]=#{selectedNode.data.resource_id}"
                else
                  move_url = "#{move_url}&media_item_ids[]=#{selectedNode.data.resource_id}"

            $('#folder-actions a.move').attr 'href', move_url
        return
      renderColumns: (event, data) ->
        node = data.node
        $tdList = $(node.tr).find('>td')
        # (Index #0 is rendered by fancytree by adding the checkbox)
        $tdList.eq(1).html node.data.favouriteStar
        # (Index #2 is rendered by fancytree)
        $tdList.eq(2).html node.data.name
        $tdList.eq(3).text node.data.size
        $tdList.eq(4).text node.data.updated
        $tdList.eq(5).text node.data.addedBy
        $tdList.eq(6).html node.data.online
        $tdList.eq(7).html node.data.archived
        return
      # activate: (event, data) ->
      #   node = data.node

      #   if node.data.href
      #     Turbolinks.visit(node.data.href)
      #     # window.open(node.data.href)
    return

  # ---
  # generated by js2coffee 2.2.0

  $('.editable').editable();