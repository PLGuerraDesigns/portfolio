'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "e67da76e3d2282f2706ee399830d30e9",
"index.html": "80d1c35279bdd35a17ec53bde859a28e",
"/": "80d1c35279bdd35a17ec53bde859a28e",
"main.dart.js": "0b09f1473522d18ef623b227468d74d3",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "baf227a07cf56a61f1a579027a3ab7ed",
"icons/Icon-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-maskable-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-maskable-512.png": "c6e9e9241cba806f198521f77ebf1446",
"icons/Icon-512.png": "c6e9e9241cba806f198521f77ebf1446",
"manifest.json": "b8bb80c94c29e93bf4dec35ebffe4a15",
"assets/AssetManifest.json": "1af90dddbba6489a6aa7903287013abf",
"assets/NOTICES": "d3f34c13c7acbf2b0db421a68a738c8b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f2163b9d4e6f1ea52063f498c8878bb9",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "1281ec2cd693e162ca7449809543fd67",
"assets/fonts/MaterialIcons-Regular.otf": "d6051ea68b7c7332308f18a8db93dff6",
"assets/assets/images/home/profile_photo.jpg": "f10b9322f41374e62f96748bad0c4b13",
"assets/assets/images/home/uark_logo.png": "bf7bfe9e2766b0388b9dfce36f8af6d8",
"assets/assets/images/home/gmu_logo.png": "8add7dc6220f1eab3f36fa985a387239",
"assets/assets/images/home/professional.png": "1a925e94e95e28f24bea33d324a53aa6",
"assets/assets/images/home/personal.png": "1d4cb269a4df5468910fb31005909475",
"assets/assets/images/professional/am3_lab/video_10.mp4": "2bbb6471d76c091e076eb3ebee7ef825",
"assets/assets/images/professional/am3_lab/video_11.mp4": "3ba7e77370dae7347388ff39057a3138",
"assets/assets/images/professional/am3_lab/video_8.mp4": "5fdb39bb0bc68030ddf24cad485cf3d5",
"assets/assets/images/professional/am3_lab/video_9.mp4": "ef94275f2b159205aa4cd4c8be20ae40",
"assets/assets/images/professional/am3_lab/image_2.png": "7530c325766da32e5796f1cd40d51aec",
"assets/assets/images/professional/am3_lab/image_3.png": "81927072ffc2aa49e1780e81392be16a",
"assets/assets/images/professional/am3_lab/image_1.png": "bad273dd664f0dc8a2dfc9d7f21b5fe4",
"assets/assets/images/professional/am3_lab/logo.png": "bf7bfe9e2766b0388b9dfce36f8af6d8",
"assets/assets/images/professional/am3_lab/image_4.png": "f3ae05892a39b8a58bc1adf428067296",
"assets/assets/images/professional/am3_lab/image_5.png": "baafab7c3689b23e06bf3720dd148856",
"assets/assets/images/professional/am3_lab/image_7.png": "f6fe30a0d8fa121a2d37a70f46f60cc1",
"assets/assets/images/professional/am3_lab/thumbnail.png": "c59b79a881da1cf7714df5e87ea25195",
"assets/assets/images/professional/am3_lab/image_6.png": "ec3ff95577da75496865253336b538a2",
"assets/assets/images/professional/am3_lab/video_4.mp4": "19e56665afa1e76d6d2faa2613a95e2e",
"assets/assets/images/professional/am3_lab/video_5.mp4": "3a3ff2537839b6a311332f9631c5cc4e",
"assets/assets/images/professional/am3_lab/video_7.mp4": "1cafb465e1adcedd9417db3e0dd3ae37",
"assets/assets/images/professional/am3_lab/video_6.mp4": "b83d1d7b0891e6892e72b2adac436e2f",
"assets/assets/images/professional/am3_lab/video_2.mp4": "05d518bde2965aa641775a2828721a6f",
"assets/assets/images/professional/am3_lab/video_3.mp4": "3f4b7568b8b91299ab042b522cf6bec5",
"assets/assets/images/professional/am3_lab/video_1.mp4": "1ede8af5ab8f9e17caf3bbf01de83c2b",
"assets/assets/images/professional/ambots/video_10.mp4": "ddee026980cc5b014cc8835d01867aa3",
"assets/assets/images/professional/ambots/image_12.png": "0d1422fa7c85e2a1dc0150ee9f5d0154",
"assets/assets/images/professional/ambots/image_10.png": "b4e899f94159886acba62837a0661340",
"assets/assets/images/professional/ambots/video_8.mp4": "6e04575882b8ce15a737201fd17faa34",
"assets/assets/images/professional/ambots/video_9.mp4": "118f31dd3490e813b19f85618e29ad01",
"assets/assets/images/professional/ambots/image_11.png": "dfa9deb9f16734af959f51b9642fd7e3",
"assets/assets/images/professional/ambots/image_8.png": "708f436c7abdc3fd804c5fe622d50193",
"assets/assets/images/professional/ambots/image_9.png": "cd3c985096a69179afdce2077ca8e0a6",
"assets/assets/images/professional/ambots/image_2.png": "2eb4203c2cda7056450c4bc8885b6d9f",
"assets/assets/images/professional/ambots/image_3.png": "7c55d3441c1fcf478b990d62b7da65cb",
"assets/assets/images/professional/ambots/image_1.png": "a00ab587c0f195bb28e8655d49284ca7",
"assets/assets/images/professional/ambots/logo.png": "d6c325ed11cea70feb0923fd52be4e0f",
"assets/assets/images/professional/ambots/image_4.png": "5f9d166ab6aa972408bfdaeb2a020b8c",
"assets/assets/images/professional/ambots/image_5.png": "771ea63f832e42e98fd1dd4f8affeb00",
"assets/assets/images/professional/ambots/image_7.png": "7d418118a30cd0d3e2e9daceefba950d",
"assets/assets/images/professional/ambots/thumbnail.png": "31dbf2aa4533d9de35e2085064a09447",
"assets/assets/images/professional/ambots/image_6.png": "00930e20c85eb343c5458cec4cedbcc5",
"assets/assets/images/professional/ambots/video_4.mp4": "8ca91c51536da23d7de92b4e7d9a35cb",
"assets/assets/images/professional/ambots/video_5.mp4": "cbf3b0e214808331f5b803aefe22be83",
"assets/assets/images/professional/ambots/video_7.mp4": "0a52553dfd8342250a4aaa447c818632",
"assets/assets/images/professional/ambots/video_6.mp4": "3314acbfa1aac3e6383179043acbac0f",
"assets/assets/images/professional/ambots/video_2.mp4": "73e0d2f2e11c7146d933dd8c317deeb1",
"assets/assets/images/professional/ambots/video_3.mp4": "4713879b66ee29d3dfef9a058348037d",
"assets/assets/images/professional/ambots/video_1.mp4": "0ebb82492534d22723d5d994a9a9c8c0",
"assets/assets/images/professional/atlantic_insurance/image_1.png": "5f07f56cec8e846458ff556bf4275df3",
"assets/assets/images/professional/atlantic_insurance/logo.png": "e95fe8aed40f6ad7a9ad0874ca34f4f7",
"assets/assets/images/professional/atlantic_insurance/thumbnail.png": "1a925e94e95e28f24bea33d324a53aa6",
"assets/assets/images/social/github_logo.png": "3e88a0de8cc52551201808266651cfaa",
"assets/assets/images/social/thingiverse_logo.png": "9092b42103f22239610c63df0c5cc9c0",
"assets/assets/images/social/linkedin_logo.png": "2e88efdd4a48a1f2a3d096768fa5cdd0",
"assets/assets/json/projects.json": "7d5b9c0c0a1c60fc672e91c36fb76bd4",
"assets/assets/json/professional_experience.json": "bc0938585780aefae7c96476d2b4b86b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
