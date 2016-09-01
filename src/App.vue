<template>
  <div id="app">
    <nav-bar></nav-bar>
    <!-- Map Row -->
    <div class="map row">
        <div class="container">
            <h5 class="title">身心障礙人口分布圖</h5>
            <div class="col s12 m12 l8 offset-l2">
              <div><d3-map></d3-map></div>
            </div>
        </div>
    </div>
    <!-- Map Row Ends -->
    <!-- Selection Row -->
    <div class="mainmenu row">
      <div class="container">
        <div class="col s12 m10 l6 offset-m1 offset-l3">
          <div class="card-panel">
            <h5 class="title">設定查詢條件</h5>
            <div class="sex"><sex v-on:sex-selected="modifySex" v-ref:sexref></sex></div>
            <div class="age"><age v-on:smaller-age-selected="modifySmallerAge" v-on:bigger-age-selected="modifyBiggerAge" v-ref:ageref></age></div>
            <div class="level"><level v-on:level-selected="modifyLevel" v-ref:levelref></level></div>
            <div class="codet"><codet v-on:codet-selected="modifyCodet" v-ref:codetref></codet></div>
            <div class="desc" style="margin: 18px 0px"><desc v-on:desc-selected="modifyDesc" v-ref:descref></desc></div>
            <div class="send-data" style="text-align: center; margin-top: 20px">
              <send-data v-on:click="sendData" v-on:peoplejson-fetched="makeNewMap"><span></span></send-data>
            </div>
          </div>
          <div class="divider"></div>
        </div>
      </div>
    </div>
    <!-- Selection Row Ends -->
    <!-- About Row -->
    <div class="about row">
      <div class="container">
        <div class="col s12 m12 l8 offset-l2">
          <h5 class="title">About 關於本計畫</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
      </div>
    </div>
    <!-- About Row Ends -->
    <fixed-footer></fixed-footer>
  </div>
</template>

<script>
import NavBar from './components/NavBar'
import Sex from './components/Sex'
import Age from './components/Age'
import Level from './components/Level'
import Codet from './components/Codet'
import Desc from './components/Desc'
import SendData from './components/SendData'
import FixedFooter from './components/Footer'
import D3Map from './components/D3Map'
import jquery from 'jquery/src/jquery.js'

var $ = jquery
window.jQuery = $
window.$ = $

export default {
  name: 'MainMenu',
  components: {
    NavBar,
    Sex,
    Age,
    Level,
    Codet,
    Desc,
    SendData,
    D3Map,
    FixedFooter
  },
  data: function () {
    return {
      sex: [],
      smallerAge: 0,
      biggerAge: 0,
      level: [],
      codet: [],
      desc: []
    }
  },
  methods: {
    modifySex: function (value) {
      this.sex = value
    },
    modifySmallerAge: function (value) {
      this.smallerAge = value
    },
    modifyBiggerAge: function (value) {
      this.biggerAge = value
    },
    modifyLevel: function (value) {
      this.level = value
    },
    modifyCodet: function (value) {
      this.codet = value
    },
    modifyDesc: function (value) {
      this.desc = value
    },
    sendData: function () {
      let jsonData = {
        'sex': this.$refs.sexref.enabled ? (this.$refs.sexref.model.length === 0 ? null : this.$refs.sexref.model.sort()) : null,
        'smallerAge': this.$refs.ageref.enabled ? this.$refs.ageref.smallerValue : null,
        'biggerAge': this.$refs.ageref.enabled ? this.$refs.ageref.biggerValue : null,
        'level': this.$refs.levelref.enabled ? (this.$refs.levelref.model.length === 0 ? null : this.$refs.levelref.model.sort()) : null,
        'codet': this.$refs.codetref.enabled ? (this.$refs.codetref.model.length === 0 ? null : this.$refs.codetref.model.sort()) : null,
        'desc': this.$refs.descref.enabled ? (this.$refs.descref.value.length === 0 ? null : this.$refs.descref.value) : null
      }
      this.$broadcast('send-data', jsonData)
    },
    makeNewMap: function (newPeopleData) {
      this.$broadcast('draw-new-map', newPeopleData)
    }
  }
}

</script>

<style>

html {
  background: #f9fbe7;
  font-family: GillSans, Calibri, Trebuchet, sans-serif;
}

#app {
  padding-bottom: 30px;
}

.section {
  padding-top: 0px !important;
  padding-bottom: 0px !important;
}

/*.section-ui-switch .ui-switch{
  margin-bottom: 8px;
}*/

.section-ui-switch .iconLabel {
  padding-left: 8px
}

/*.section-ui-switch .ui-button {
    margin-top: 24px;
}*/

.mainmenu .divider {
  margin-bottom: 20px;
}

.mainmenu .ui-switch-label-text {
  color: #2c3e50;
}

/*.mainmenu .col {
  padding: 0px!important;
}*/

.mainmenu div.card-panel {
  opacity: 0.8;
  padding: 10px 30px 30px 30px;
  border-radius: 3%;
  /*overflow-y: scroll;*/
  margin-bottom: 2rem;
}

.title {
  text-align: center;
  padding: 5px 0px;
  font-weight: 800;
}

</style>
