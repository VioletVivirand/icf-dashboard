<template>
  <div>
    <div><ui-button icon="map" color="primary">重新產生地圖</ui-button></div>
    <!-- <span>[Debug] {{jsonData | json}}</span> -->

  </div>
</template>

<script>
import Vue from 'vue'
import VueResource from 'vue-resource'
import UiButton from 'keen-ui/lib/UiButton'
import serverConf from '../assets/json/serverConf.json'

Vue.use(VueResource)

export default {
  components: {
    VueResource, UiButton
  },
  data () {
    return {
      jsonData: null,
      text: ''
    }
  },
  events: {
    'send-data': function (value) {
      this.jsonData = value
      let parameters = {}
      for (let i in this.jsonData) {
        if (this.jsonData[i]) {
          try {
            parameters[i] = this.jsonData[i].join(',')
          } catch (e) {
            parameters[i] = this.jsonData[i]
          }
        }
      }
      Vue.http.get(serverConf.serverRoot + serverConf.apiEndpoint, {params: parameters}).then((response) => {
        this.$dispatch('peoplejson-fetched', JSON.parse(response.data))
      }, (response) => {
        // error callback
        console.log('Error occurs when fetching API')
      })
      parameters = {}
    }
  }
}

</script>

<style lang="stylus">
/* TODO: Sample Style Sheet */
</style>