<template>
  <f7-page name="home" @page:init="pageInit">
    <!-- Top Navbar -->
    <f7-navbar large>
      <f7-nav-title>CarPlayDemo</f7-nav-title>
      <f7-nav-title-large>CarPlayDemo</f7-nav-title-large>
    </f7-navbar>

    <!-- Page content-->
    <f7-block strong>
      Open simulator, I/O, External Display, CarPlay and run app
    </f7-block>

    <f7-block strong>
      Should use entitlement <b>com.apple.developer.carplay-charging</b>
    </f7-block>
  </f7-page>
</template>

<script>
export default {
  methods: {

    pageInit() {
      setTimeout(this.loadSample, 2000)
    },

    loadSample () {
      if (cordova){
        if (window.plugins && typeof window.plugins.carplayAndroidAutoPlugin != 'undefined') {
          var tracks = [];
          tracks.push({ itemKey: "0", id: "M1", subtitle: "This is a test", title: "Sample list" });
          tracks.push({ itemKey: "1", id: "M2", subtitle: "Using com.apple.developer.playable-content", title: "This is using" });
          window.plugins.carplayAndroidAutoPlugin.setMediaItems(tracks);
        } else {
          alert('Plugin not found')
        }
      }
    }
  }
}
</script>