<template>
  <div class="section-ui-switch">
    <h4>
      <form v-on:change="notifyLevelEnabled"><ui-switch name="enabled" :value.sync="enabled" label-left>
        <ui-icon icon="equalizer"></ui-icon><span class="iconLabel">設定查詢身心障礙等級條件</span></ui-switch>
      </form>
    </h4>
  </div>
  <div class="section-ui-checkbox" v-show="enabled">
    <div class="group">
      <ui-checkbox
          name="codet" :model.sync="model" value="1" :disabled="!enabled" v-on:change="notifyLevelSelected"
      >輕度</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="2" :disabled="!enabled" v-on:change="notifyLevelSelected"
      >中度</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="3" :disabled="!enabled" v-on:change="notifyLevelSelected"
      >重度</ui-checkbox>
      <ui-checkbox
          name="codet" :model.sync="model" value="4" :disabled="!enabled" v-on:change="notifyLevelSelected"
      >極重度</ui-checkbox>
    </div>
    <div class="divider"></div>
  </div>
  <!-- DEBUG -->
  <!-- <div>[DEBUG] model = {{ model | json }} </div>
  <div>[DEBUG] enabled = {{ enabled }} </div> -->
</template>

<script>
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
    notifyLevelSelected: function () {
      if (this.model) {
        // console.log('[DEBUG] selected!')
        this.$dispatch('level-selected', this.model)
      }
    },
    notifyLevelEnabled: function () {
      if (this.enabled) {
        // console.log('[DEBUG] from false to true!')
        this.$dispatch('level-selected', this.model)
      } else {
        // console.log('[DEBUG] from true to false!')
        this.$dispatch('level-selected', [])
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