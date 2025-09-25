'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "888483df48293866f9f41d3d9274a779",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "0fc600d3bec1d7f714945b8ee3d25718",
"index.html": "ec1233364e96b729d4defc93abfcf4c1",
"/": "ec1233364e96b729d4defc93abfcf4c1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "129e5f5a71ea312e75600067e5eb6353",
"assets/lib/assets/ctEvents/past_12.599d30a9dda6becad387.png": "1ee24a74bfc3ced9b0a52668e2a31418",
"assets/lib/assets/ctEvents/past_14.7b2dc2209af480cacead.png": "c5386188189d9e6223a95c291112f05d",
"assets/lib/assets/ctEvents/past_13.2e63da7d68cb5536d6a9.png": "006cfbdf803032a308ffbe2a11e3b7d5",
"assets/lib/assets/ctEvents/past_10.437b7a9c511d8d650b42.png": "7fad0248312faccb8267da3d5465d2f6",
"assets/lib/assets/ctEvents/past_7.4c458172ad4bc461cfae.png": "05bff9dc36974cbb9c06a3ac56839f56",
"assets/lib/assets/ctEvents/past_9.edbe9c144008f2ca5ad1.png": "74b36d2a57d86420386b4563d7c9aa51",
"assets/lib/assets/ctEvents/download.png": "6ce9efe6e2145e147bf0e583ab059342",
"assets/lib/assets/ctEvents/download%2520(1).png": "9c764860b9437f0655dad78fe466f19a",
"assets/lib/assets/ctEvents/past_11.151f2d5db6fadf8c5d89.png": "282b327fe4f4b4d7910ba169bfbe261f",
"assets/lib/assets/caro_chennai_new.png": "7a87d709473b605fb118268b90c8e40d",
"assets/lib/assets/creedom_logo_color.png": "7a42fcb785f371bb06c6d016d4a0d601",
"assets/lib/assets/acting.png": "9e63a264e26d203a376756c4d2a11fc5",
"assets/lib/assets/dr.png": "5c1b9a1db41db7167ebc3e185559802f",
"assets/lib/assets/singing_card.png": "211ab734f1d67dc1fd0564c5d46eab14",
"assets/lib/assets/Creedom_logo-01.png": "4287582a7d4c0cc6fa60ac0d78dfb6b8",
"assets/lib/assets/acting_bg.png": "940aa05980eee2e646768aed60c69b46",
"assets/lib/assets/cat1.png": "24ff1994293092970b38804511717ce9",
"assets/lib/assets/sponser.png": "f4a0163d0c38ed22a9ab3ba6dfa67c46",
"assets/lib/assets/arts.png": "48e1bbcdd7aed33ee33513195cb2ea91",
"assets/lib/assets/homepage.jpg": "3259e162b682e0707cd523d267631e52",
"assets/lib/assets/creedom_logo.png": "f8f43eb4ff9c18b1494c9742cb8fb4eb",
"assets/lib/assets/eng.png": "b0e1bb095beaf4282bd2c68be7871ec4",
"assets/lib/assets/dancing_bg.png": "bd14a85c4db9cbc38551955017711729",
"assets/lib/assets/spec.png": "e5bf7d2993d7827a4944f19d0bfe58e4",
"assets/lib/assets/singing.png": "efef3c25994558be7a470a66d136cbbf",
"assets/lib/assets/Right-decoration-1024x751.png": "bb36d1e1f7dd2212962b6015d9f7713f",
"assets/lib/assets/bgmain.png": "ec7f264458bd41421c3a4421f20c639e",
"assets/lib/assets/bg.jpg": "8a2dffa82773b8f67607d852e8c794d8",
"assets/lib/assets/cat1_new.png": "c3eb24f16c1d3c6692cc88fd785084ff",
"assets/lib/assets/2X.png": "ab63d463711e1d580f76b27e7a08d8cb",
"assets/lib/assets/photography.png": "19238a5b48d951b5863c319ad22a993a",
"assets/lib/assets/logo.png": "30df90e8095bfe80c18b15b739d5f4aa",
"assets/lib/assets/law.png": "ab39756db04f695e25fcc19292c12ccc",
"assets/lib/assets/Grand%2520opening.json": "c6e4706f5ef801775f90eb11de7aaee0",
"assets/lib/assets/college_logo.png": "f78eeefbfd3d99e0d9e7d454db011fdc",
"assets/lib/assets/mobile_homepage.jpg": "e39f50e7783ca771f4d70a6a4beb89c6",
"assets/lib/assets/caro_chennai.png": "47382bdd24fbf713625a1597676f4315",
"assets/lib/assets/dance.png": "2fb70c331ccbb4423519327401a5dd8e",
"assets/lib/assets/acting_card.png": "fb54187578cc1e887c573290533d58f1",
"assets/lib/assets/Left-decoration-1024x751.png": "2c7eff75e61c2f580992432b78133ede",
"assets/lib/assets/swipe%2520left.json": "9c0ee12f328e7342f28276e46c97c39b",
"assets/lib/assets/photo_card.png": "ca2b042a4669e19eb50b3861af253aeb",
"assets/lib/assets/singing_bg.png": "d54cfcbbfeafaf90d4e9dd09ef7806cd",
"assets/fonts/MaterialIcons-Regular.otf": "e1441b0d19cb407878f04d2b1e9fd894",
"assets/NOTICES": "85b6403951e20f12330d2a2c20f535a2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "1bcc9cbee76a46bbf1a24d049433530f",
"assets/AssetManifest.json": "c5cda22c5b12b52f0602c17c377398a5",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "9623cd30008b0d0c098c89be2c0e77a0",
"version.json": "1610d62db1f22cdb5fe9a38c24556d95",
"main.dart.js": "8b654f5c63212966448eb5aa28b2fadf"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
