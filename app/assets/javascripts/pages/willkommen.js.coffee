#= require vendor/raphaeljs

Raphael.fn.circleNavigation = (centerX, centerY, radius, linkList, infoText) ->
  
  paper = this
  linkCount = linkList.length 
  sectorAngle = 360 / linkCount
  radiant = Math.PI / 180
  neutralInfoText = infoText.html()
  
  # background gradient
  paper.circle(centerX, centerY, radius).attr
    fill: 'r(0.5, 0.5)#ccc-#fff',
    stroke: 'none'
  
  drawCircleSector = (startAngle, endAngle, configuration) ->
    x1 = centerX + radius * Math.cos(-startAngle * radiant)
    x2 = centerX + radius * Math.cos(-endAngle * radiant)
    y1 = centerY + radius * Math.sin(-startAngle * radiant)
    y2 = centerY + radius * Math.sin(-endAngle * radiant)

    paper.path(["M", centerX, centerY, 
                "L", x1, y1, 
                "A", radius, radius, 0, +(endAngle - startAngle > 180), 0, x2, y2, "z"])
                .attr(configuration)

  createSector = (index, link) ->
    startAngle = 90 - sectorAngle * index
    endAngle = startAngle + sectorAngle
    middleAngle = endAngle - (endAngle - startAngle) / 2
    
    middleAngle = 360 + middleAngle if middleAngle < 0
    
    sector = drawCircleSector startAngle, endAngle,
      fill: "#{middleAngle}-rgba(131, 160, 212, 0.2)-rgba(255, 255, 255, 0):80"
      "fill-opacity": 0
      stroke: '#fff', 
      "stroke-width": 3
      href: link.attr('href')
    
    linkX = centerX - link.outerWidth() / 2 + 80 + (radius-30) * Math.cos(-middleAngle * radiant)
    linkY = centerY - 50 + (radius-30) * Math.sin(-middleAngle * radiant)
    
    link.css position: 'absolute', left: linkX, top: linkY
      
    sector.mouseover -> sector.stop().animate { "fill-opacity": 1 }, 200
    
    link.mouseover -> infoText.html link.attr('title')
      
    sector.mouseout -> sector.stop().animate { "fill-opacity": 0 }, 200
      
    link.mouseout -> infoText.html neutralInfoText
      
  
  for index in [0...linkCount]
    createSector index, linkList.eq(index)
    
  infoCircle = paper.circle(centerX, centerY, radius / 1.8).attr
    fill: '#2e4672'
    stroke: '#fff'
    "stroke-width": 5
 
jQuery ->
  links = $('#circle-navigation li a')
  infoText = $('#info-text')
  
  Raphael('circle-navigation', 800, 600).circleNavigation 400, 300, 300, links, infoText