<template>
  <div class="section-ui-switch">
    <h4>
      <form v-on:change="notifySexEnabled">
        <ui-switch name="enabled" :value.sync="enabled" label-left>
          <ui-icon icon="wc" v-on:change="notifySexEnabled"></ui-icon><span class="iconLabel">設定查詢性別條件</span>
        </ui-switch>
      </form>
    </h4>
  </div>
  <div class="section-ui-checkbox" v-show="enabled">
    <div class="group valign">
      <ui-checkbox 
          name="codet" 
          :model.sync="model" 
          value="1" 
          :disabled="!enabled" 
          v-on:change="notifySexSelected">
          男性
      </ui-checkbox>
      <ui-checkbox 
        name="codet" 
        :model.sync="model" 
        value="2" 
        :disabled="!enabled" 
        v-on:change="notifySexSelected">
        女性
      </ui-checkbox>
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
    notifySexSelected: function () {
      if (this.model) {
        // console.log('[DEBUG] selected!')
        this.$dispatch('sex-selected', this.model)
      }
    },
    notifySexEnabled: function () {
      if (this.enabled) {
        // console.log('[DEBUG] from false to true!')
        this.$dispatch('sex-selected', this.model)
      } else {
        // console.log('[DEBUG] from true to false!')
        this.$dispatch('sex-selected', [])
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