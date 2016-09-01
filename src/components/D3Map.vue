<template>
  <div>
    <div id="chart"></div>
  </div>
</template>

<script>
import topojson from 'topojson/build/topojson.js'
import towntopojson from '../assets/json/towns-topojson.json'
import Allpeople from '../assets/json/allpeople.json'
import d3 from 'd3/d3.js'
import 'd3-svg-legend'
import jquery from 'jquery/src/jquery.js'

var $ = jquery
window.jQuery = $
window.$ = $

var width = 530
var height = 470
var data = topojson.feature(towntopojson, towntopojson.objects.towns).features

var projection = d3.geo.mercator()
  .center([121, 24])
  .scale(7000)
  .translate([400, 180])

// 顏色尺度 for Horizontal d3-legend
var linear = d3.scale.linear()
  .range(['#FFE4B5', '#F64403'])

var path = d3.geo.path()
  .projection(projection)

var svg = null
var tooltip = null

var binddom = function () {
  svg = d3.select('div#chart').append('svg')
    .attr('width', width)
    .attr('height', height)

  // 新增 d3-legend
  // Horizontal Legend
  // svg.append('g')
  //   .attr('class', 'horizontalLegend')
  //   .attr('transform', 'translate(50,400)')

  // Vertical Legend
  svg.append('g')
    .attr('class', 'verticalLegend')
    .attr('transform', 'translate(50,250)')

  tooltip = d3.select('div#chart')
    .append('div')
    .attr('id', 'tooltip')
    .style('visibility', 'hidden')
}

// TODO: Responsive via resize()
// http://bl.ocks.org/jczaplew/4444770
// http://bl.ocks.org/radiocontrolled/7698088
var redraw = function (peopleData) {
  var sortedData = data.sort(function (a, b) {
    return peopleData[b['id']] - peopleData[a['id']]
  })

  // 幫 d3-legend linear 尺度指定資料範圍
  // 在這邊，sortedData[0]["properties"][selectedType]] 剛好會是最大值
  linear.domain([0, peopleData[sortedData[0]['id']]])
  // Data Join
  var town = svg.selectAll('.town')
    .data(data, function (d) {
      return d['id']
    })
  // Enter
  var townEnter = town.enter()
    // .insert('g', '.horizontalLegend')  // 這只是為了讓 d3-legend 跟在一堆 g.town 後面所以順便新增的
    .insert('g', '.verticalLegend')
    .attr('class', 'town')
    .style('fill-opacity', 0)
  // Enter - town Path
  townEnter.append('path')
    .attr('id', function (d) {
      return d.id
    })
    .attr('d', path)
  // Mouse Events
  town.select('path')
    .on('mouseover', function () {
      return tooltip.style('visibility', 'visible')
    }).on('mousemove', function (d) {
      return tooltip
        .style('top', (d3.event.pageY - 10) + 'px')
        .style('left', (d3.event.pageX + 10) + 'px')
        .html(tooltipHtml(d['properties']['NAME'], peopleData[d['id']]))
    }).on('mouseout', function () {
      return tooltip.style('visibility', 'hidden')
    })
  // Legend (With D3-Legend)
  // Horizontal Legend
  // var legend = d3.select('.horizontalLegend')
  // var legendLinear = d3.legend.color()
  //   .shapeWidth(30)
  //   .cells(10)
  //   .orient('horizontal')
  //   .scale(linear)
  //   .title('身心障礙人口數')
  // legend.call(legendLinear)

  // Vertical Legend
  var legend = d3.select('.verticalLegend')
  var linearLegend = d3.legend.color()
      .cells(10)
      .scale(linear)
      .title('身心障礙人口數')
  legend.call(linearLegend)

  // Update
  var townUpdate = d3.transition(town)
    .style('fill-opacity', 1)
  // Update - town Path
  townUpdate.select('path')
    .style('fill', function (d) {
      return peopleData[d['id']] === undefined ? '' : linear(peopleData[d['id']])
    })
  // // Update - town Name
  // townUpdate.select(".label")
  //     .text(function(d) {
  //         return d["properties"]["NAME"];
  //     });
  // Exit
  var townExit = d3.transition(town.exit())
    .style('fill-opacity', 0)
    .remove()
  // Exit - town Path
  townExit.select('path')
    .style('fill', function (d) {
      return linear(peopleData[d['id']])
    })
  // Exit - town Name
  townExit.select('.label')
    .text(function (d) {
      return d['properties']['NAME']
    })
}

var tooltipHtml = function (town, people) {
  var code = '<p id="tooltip-town-name">' + town + '</p><hr>' + '<p id="tooltip-tax"><span id="tooltip-legend-icon" style="color: ' + (people === undefined ? '#ECECEC' : linear(people)) + '; ">●</span><span id="tooltip-value"> ' + (people === undefined ? '無資料' : people) + '</span></p>'
  return code
}

var roundLegendLabel = function (labels) {
  for (let i in [...Array(10).keys(labels.length)]) {
    labels[i].textContent = String(Math.round(labels[i].textContent))
  }
}

export default {
  ready () {
    binddom()
    redraw(Allpeople)
    roundLegendLabel($('g.legendCells text.label'))
  },
  events: {
    'draw-new-map': function (value) {
      redraw(value)
      roundLegendLabel($('g.legendCells text.label'))
    }
  }
}

</script>

<style>
.town path {
  fill: #ECECEC;
}

.town path:hover {
  /*stroke: #FFFFFF;*/
  stroke-width: 1px;
  fill-opacity: 0.7;
}

.town text {
  fill: black;
  font-size: 8px;
}

div {
  font-family: 'Open Sans', sans-serif;
}

div#tooltip {
  position: absolute;
  z-index: 10;
  width: 100px;
  border: 1px solid #cccccc;
  border-radius: 5px;
  padding: 0px 10px 0px 10px;
  background: #F7F7F7;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.3);
}

div#tooltip p {
  line-height: 1.2em;
  text-align: center
}

div#tooltip hr {
  border: 0;
  height: 0;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}

p#tooltip-town-name {
  color: #666666;
  font-size: 14px;
  font-weight: 600;
}

p#tooltip-tax {
  font-size: 10px;
  font-weight: 800;
  color: #666666;
  font-weight: 300;
}

span#tooltip-legend-icon {
  font-size: 16px;
  text-shadow: 0px 0px 3px rgba(0, 0, 0, 0.7);
}

span#tooltip-value {
  vertical-align: 0.1em;
}

/*.horizontalLegend {
  font-size: 10px;
  font-weight: 600;
}

.horizontalLegend .legendTitle {
  transform: translate(0, 15px);
  font-size: 12px;
  font-weight: 800;
}*/

.verticalLegend {
  font-size: 10px;
  font-weight: 600;
}

.verticalLegend .legendTitle {
  transform: translate(0, 15px);
  font-size: 12px;
  font-weight: 800;
}
</style>
