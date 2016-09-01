<template>
  <div class="section-ui-switch">
    <form v-on:change="notifyDescEnabled"><ui-switch name="enabled" :value.sync="enabled" label-left>
      <ui-icon icon="list"></ui-icon><span class="iconLabel">設定查詢疾病條件</span></ui-switch>
    </form>
  </div>
  <div class="section-ui-select" v-show="enabled" style="margin-top: 10px">
    <ui-select
      name="diseases"
      label="疾病"
      :options="diseases"
      :value.sync="value"
      placeholder="請選擇疾病名稱"
      multiple-delimiter="、"
      show-search
      multiple
      v-on:click="notifyDescSelected"
    ></ui-select>
  </div>
  <!-- DEBUG -->
  <!-- <div>[DEBUG] value = {{ value | json }} </div>
  <div>[DEBUG] enabled = {{ enabled }} </div> -->
</template>

<script>
import UiSwitch from 'keen-ui/lib/UiSwitch'
import UiSelect from 'keen-ui/lib/UiSelect'
import UiIcon from 'keen-ui/lib/UiIcon'
import Descriptions from 'raw!../assets/txt/descriptions.txt'

let diseases = Descriptions.split('\n').slice(0, 200)

export default {
  components: {
    UiSwitch,
    UiSelect,
    UiIcon
  },
  data () {
    return {
      diseases,
      value: null,
      options: [],
      timeout: null,
      loading: false,
      optionsLoaded: false,
      enabled: false
    }
  },
  methods: {
    notifyDescSelected: function () {
      if (this.value) {
        // console.log('[DEBUG] selected!')
        this.$dispatch('desc-selected', this.value)
      }
    },
    notifyDescEnabled: function () {
      if (this.enabled) {
        // console.log('[DEBUG] from false to true!')
        this.$dispatch('desc-selected', this.value)
      } else {
        // console.log('[DEBUG] from true to false!')
        this.$dispatch('desc-selected', [])
      }
    }
  }
}
</script>

<style>
input.ui-select-search-input {
  margin: 0!important;
  border: none!important;
  outline: none!important;
  background: none!important;
  padding: 0 12px!important;
  width: 100%!important;
  height: 42px!important;
  font-size: 15px!important;
  border-bottom: 1px solid rgba(0,0,0,.12)!important;
}
</style>