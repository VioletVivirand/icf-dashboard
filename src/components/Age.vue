<template>
  <div class="section-ui-switch">
    <h4>
      <form v-on:change="notifyAgeEnabled"><ui-switch name="enabled" :value.sync="enabled" label-left><ui-icon icon="date_range"></ui-icon><span class="iconLabel">設定查詢年齡條件</span></ui-switch></form>
    </h4>
  </div>
  <div class="section-ui-textbox" v-show="enabled">
    <ui-textbox
      label="年齡大於"
      name="age"
      type="number"
      placeholder="請輸入年齡下限"
      :min=18
      :max=112
      help-text="年齡需介於 18 到 112 歲之間"
      validation-rules="numeric|min:18|max:112"
      icon="keyboard_arrow_right"
      :validation-messages="validationErrorMessages"
      v-on:change="smallerAgeSelected"
      :value.sync="smallerValue"
      :valid.sync="smallerValid"
    ></ui-textbox>

    <ui-textbox
      label="年齡小於"
      name="age"
      type="number"
      placeholder="請輸入年齡上限"
      :min=18
      :max=112
      help-text="年齡需介於 18 到 112 歲之間"
      validation-rules="numeric|min:18|max:112"
      icon="keyboard_arrow_left"
      :validation-messages="validationErrorMessages"
      v-on:change="biggerAgeSelected"
      :value.sync="biggerValue"
      :valid.sync="biggerValid"
    ></ui-textbox>
    <div class="divider"></div>
  </div>
  <!-- DEBUG -->
  <!-- <div>[DEBUG] mallerValue = {{smallerValue}}</div>
  <div>[DEBUG] biggerValue = {{biggerValue}}</div>
  <div>[DEBUG] enabled = {{enabled}}</div> -->
</template>

<script>
import UiSwitch from 'keen-ui/lib/UiSwitch'
import UiTextbox from 'keen-ui/lib/UiTextbox'
import UiIcon from 'keen-ui/lib/UiIcon'

export default {
  components: {
    UiSwitch,
    UiTextbox,
    UiIcon
  },
  data () {
    return {
      validationErrorMessages: {
        min: {
          numeric: '年齡不可小於 :min'
        },
        max: {
          numeric: '年齡不可大於 :max'
        }
      },
      isValid: true,
      smallerValue: 18,
      biggerValue: 112,
      smallerValid: true,
      biggerValid: true,
      enabled: false
    }
  },
  methods: {
    smallerAgeSelected: function () {
      if (this.smallerValue && this.smallerValid) {
        if (this.smallerValue > this.biggerValue) {
          this.smallerValue = this.biggerValue
        }
        console.log(this.smallerValid)
        this.$dispatch('smaller-age-selected', this.smallerValue)
      }
    },
    biggerAgeSelected: function () {
      if (this.biggerValue && this.biggerValid) {
        if (this.biggerValue < this.smallerValue) {
          this.biggerValue = this.smallerValue
        }
        console.log(this.biggerValid)
        this.$dispatch('bigger-age-selected', this.biggerValue)
      }
    },
    notifyAgeEnabled: function () {
      if (this.enabled) {
        // console.log('[DEBUG] from false to true!')
        this.$dispatch('smaller-age-selected', this.smallerValue)
        this.$dispatch('bigger-age-selected', this.biggerValue)
      } else {
        // console.log('[DEBUG] from true to false!')
        this.$dispatch('smaller-age-selected', [])
        this.$dispatch('bigger-age-selected', [])
      }
    }
  }
}
</script>

<style lang="stylus">
</style>