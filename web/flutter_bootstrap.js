{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}}
  },
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
    if (window.notifyFlutterReady) {
      window.notifyFlutterReady();
    } else {
      const loader = document.getElementById('loading-screen');
      if (loader) {
        loader.classList.add('fade-out');
        setTimeout(function() {
          if (loader.parentNode) {
            loader.parentNode.removeChild(loader);
          }
        }, 400);
      }
    }
  }
});
