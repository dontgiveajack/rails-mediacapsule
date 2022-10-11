# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Call the dataTables jQuery plugin
$(document).on 'turbolinks:load', ->

  if $('#archiveStorage').length > 0
    # Set new default font family and font color to mimic Bootstrap's default styling
    Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif'
    Chart.defaults.global.defaultFontColor = '#292b2c'
    
    # Donut Chart Example for online storage
    # ctx = document.getElementById('onlineStorage')
    # onlineChart = new Chart(ctx,
    #   type: 'doughnut'
    #   options: cutoutPercentage: 80
    #   data:
    #     labels: [
    #       'Used'
    #       'Available'
    #     ]
    #     datasets: [ {
    #       data: [
    #         10
    #         20
    #       ]
    #       backgroundColor: [
    #         '#007bff'
    #         '#ececec'
    #       ]
    #     } ])
    # # Donut Chart Example for archive storage
    # ctx = document.getElementById('archiveStorage')
    # archiveChart = new Chart(ctx,
    #   type: 'doughnut'
    #   options: cutoutPercentage: 80
    #   data:
    #     labels: [
    #       'Used'
    #       'Available'
    #     ]
    #     datasets: [ {
    #       data: [
    #         0
    #         100
    #       ]
    #       backgroundColor: [
    #         '#dc3545'
    #         '#ececec'
    #       ]
    #     } ])
    ##28a745

    # $('#dataTable').DataTable()
    return
