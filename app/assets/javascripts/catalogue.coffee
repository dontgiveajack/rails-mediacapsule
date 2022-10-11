# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
#   if $('#tree').length > 0 
#     # Initialize Fancytree
#     $('#tree').fancytree
#       extensions: [
#         'glyph'
#         'table'
#         'dnd5'
#       ]
#       renderNode: (event, data) ->
#         # need to ability escape HTML
#         return
#       escapeTitles: false
#       autoScroll: true
#       selectMode: 2
#       checkbox: true
#       dnd5:
#         preventVoidMoves: true
#         preventRecursiveMoves: true
#         autoExpandMS: 400
#         dragStart: (node, data) ->
#           return true
#         dragEnter: (node, data) ->
#           return true        
#         dragDrop: (node, data) ->
#           data.otherNode.moveTo node, data.hitMode                          
#       glyph:
#         preset: 'awesome5'
#         map:
#           folder: 'fas fa-folder'
#           folderOpen: 'fas fa-folder-open'
#       source: [
#         {
#           'title': 'Loading'
#           'folder': true
#           'online': ''
#           'archived': ''
#           'size': 'Loading'
#           'addedBy': 'Loading'
#           'updated': 'Loading'
#         }
#       ]
#       table:
#         checkboxColumnIdx: 0
#         nodeColumnIdx: 2
#       init: (event, data) ->
#         node = $('#tree').fancytree('getRootNode')
#         comparer = (index) ->
#           (a, b) ->
#             valA = getCellValue(a, index)
#             valB = getCellValue(b, index)
#             if $.isNumeric(valA) and $.isNumeric(valB) then valA - valB else valA.toString().localeCompare(valB)

#         getCellValue = (row, index) ->
#           $(row).children('td').eq(index).text()

#         $('.sort').click ->
#           $('th').removeClass('active')          
#           table = $(this).parents('table').eq(0)
#           rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
#           $(this).toggleClass 'active'
#           $(this).toggleClass 'sortDSC'         
#           @asc = !@asc
#           if !@asc
#             rows = rows.reverse()
#           i = 0
#           while i < rows.length
#             table.append rows[i]
#             i++
#           return
#       select: (event, data) ->
#         #need to keep toggle for multiple selected folders
#         selNodes = data.tree.getSelectedNodes()
#         if selNodes.length > 0
#           $('#folder-actions').addClass 'd-inline-block'
#         else
#           $('#folder-actions').removeClass 'd-inline-block'
#         return
#       renderColumns: (event, data) ->
#         node = data.node
#         $tdList = $(node.tr).find('>td')
#         # (Index #0 is rendered by fancytree by adding the checkbox)
#         $tdList.eq(1).html '<input class="star" type="checkbox"/><label for="star test"></label>'
#         # (Index #2 is rendered by fancytree)
#         $tdList.eq(3).text node.data.size
#         $tdList.eq(4).text node.data.updated
#         $tdList.eq(5).text node.data.addedBy
#         $tdList.eq(6).html node.data.online
#         $tdList.eq(7).html node.data.archived
#         return
#     return

#   # ---
#   # generated by js2coffee 2.2.0