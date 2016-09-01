<template>
  <div class="section-ui-switch">
    <h4>
      <form v-on:change="notifyCodetEnabled"><ui-switch name="enabled" :value.sync="enabled" label-left><ui-icon icon="accessible"></ui-icon><span class="iconLabel">設定查詢身心障礙類別條件</span></ui-switch></form>
    </h4>
  </div>
  <div class="section-ui-checkbox" v-show="enabled">
    <div class="group">
      <ui-checkbox
          name="codet" :model.sync="model" value="1" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 1 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="2" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 2 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="3" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 3 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="4" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 4 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="5" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 5 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="6" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 6 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="7" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 7 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="8" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 8 類</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="9" :disabled="!enabled" v-on:change="notifyCodetSelected"
      >第 1 和第 7 類</ui-checkbox>
    </div>
    <div class="divider"></div>
  </div>
  <!-- DEBUG -->
  <!-- <div>[DEBUG] model = {{ model | json }} </div>
  <div>[DEBUG] enabled = {{ enabled }} </div> -->
</template>

<script>
var $ = require('jquery')
window.$ = $
window.jQuery = $
import UiSwitch from 'keen-ui/lib/UiSwitch'
import UiCheckbox from 'keen-ui/lib/UiCheckbox'
import UiIcon from 'keen-ui/lib/UiIcon'

export default {
  data () {
    return {
      model: [],
      enabled: false
    }
  },
  components: {
    UiSwitch,
    UiCheckbox,
    UiIcon
  },
  methods: {
    notifyCodetSelected: function () {
      if (this.model) {
        // console.log('[DEBUG] selected!')
        this.$dispatch('codet-selected', this.model)
      }
    },
    notifyCodetEnabled: function () {
      if (this.enabled) {
        // console.log('[DEBUG] from false to true!')
        this.$dispatch('codet-selected', this.model)
      } else {
        // console.log('[DEBUG] from true to false!')
        this.$dispatch('codet-selected', [])
      }
    }
  }
}
</script>

<style lang="stylus">
.section-ui-checkbox {
  .group {
    overflow: hidden;
    display: inline-block;
    &.label-left {
      max-width: 200px;
    }
    .ui-checkbox {
      float: left;
      margin-right:20px;
    }
  }
}
</style>