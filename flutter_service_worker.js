'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"manifest.json": "b8bb80c94c29e93bf4dec35ebffe4a15",
"index.html": "f418547ef5fa2670fe89d96e8b961ccf",
"/": "f418547ef5fa2670fe89d96e8b961ccf",
"assets/AssetManifest.bin": "9888e9d17d31f4f09924ea0e0fda1293",
"assets/fonts/MaterialIcons-Regular.otf": "c57945678d2cbfc94fb32e56972c4d27",
"assets/assets/images/personal/flutter_resume_builder/thumbnail.png": "bd3df6e40a06a3c074108f9a28160845",
"assets/assets/images/personal/blokus/thumbnail.png": "ec62a0c9c2187d28fce9dd3e5936dc8d",
"assets/assets/images/personal/led_wall_decor/thumbnail.png": "03b1ff4d670936d0acf865f1c1ac4c6a",
"assets/assets/images/personal/led_wall_decor/image_2.png": "97f8b0d4f8d20c62fa56fb497c0131d5",
"assets/assets/images/personal/led_wall_decor/image_1.png": "a407c9314cd0ca1499d6fe191540d13c",
"assets/assets/images/personal/f1_sim_engineer/thumbnail.png": "f8e3102753d8890c4add4dca7a5d02c9",
"assets/assets/images/personal/f1_sim_engineer/video_1.mp4": "c0c2de57b37041fcdd5a6a08e6d19495",
"assets/assets/images/personal/safedrive_mk1/image_5.png": "5953b7b84eb890ae9f829c641b0abeaf",
"assets/assets/images/personal/safedrive_mk1/thumbnail.png": "378b2c1a5b061271f4ca8557691d228d",
"assets/assets/images/personal/safedrive_mk1/video_3.mp4": "4b6a4a6ce34ca4f8449a3b404c2c2f60",
"assets/assets/images/personal/safedrive_mk1/image_8.png": "0fbfd6da30fb8b462c0cf9bb459eefeb",
"assets/assets/images/personal/safedrive_mk1/video_2.mp4": "cee454902c23d32dcef8b06fcdb82892",
"assets/assets/images/personal/safedrive_mk1/image_2.png": "6372bbc5a3309c76450387f75334cb85",
"assets/assets/images/personal/safedrive_mk1/video_1.mp4": "94d8b6e747c6ed60489368aeac680eea",
"assets/assets/images/personal/safedrive_mk1/image_3.png": "73aec2e66270ef3856d4dd044a9d0abb",
"assets/assets/images/personal/safedrive_mk1/image_4.png": "88f4e5d643cfa18ca64ff621f09f5569",
"assets/assets/images/personal/safedrive_mk1/video_4.mp4": "61e565fd54f84f32bcb276f347cbf69c",
"assets/assets/images/personal/safedrive_mk1/image_1.png": "2213e6893f4ce27be0b9cb5fe5884643",
"assets/assets/images/personal/safedrive_mk1/image_9.png": "0f9dbc57fa8a9f5b4dfe85bc78aa79d8",
"assets/assets/images/personal/safedrive_mk1/image_7.png": "463270dc49481364ecb4715219db2807",
"assets/assets/images/personal/safedrive_mk1/image_6.png": "70c19949ac83b04b85dc57297a6f0266",
"assets/assets/images/personal/amg_gt3_wheel/image_5.png": "169215fa5b8ee9c433d9669055871209",
"assets/assets/images/personal/amg_gt3_wheel/image_14.png": "cece316ed0c28ffc3abb357cff0c889c",
"assets/assets/images/personal/amg_gt3_wheel/thumbnail.png": "69afbb633f09ed67ec7f21b70a9b88fc",
"assets/assets/images/personal/amg_gt3_wheel/image_8.png": "57eeb8bee568842e28be18637d7151a9",
"assets/assets/images/personal/amg_gt3_wheel/video_2.mp4": "e7fcc06502cfe260e9ad61bc8e0aa92d",
"assets/assets/images/personal/amg_gt3_wheel/image_2.png": "932c708de831f9d165daa6bdf053ea10",
"assets/assets/images/personal/amg_gt3_wheel/video_1.mp4": "f84478726d3705be2c325edd1feba0a3",
"assets/assets/images/personal/amg_gt3_wheel/image_3.png": "6e94a00e38616b2e165480a728a7e524",
"assets/assets/images/personal/amg_gt3_wheel/image_4.png": "3cfb5316abe4d40de312d9b467864412",
"assets/assets/images/personal/amg_gt3_wheel/image_13.png": "22f95591d8ddc4ae2fc567ad287541f1",
"assets/assets/images/personal/amg_gt3_wheel/image_1.png": "eb22d20cdf48d4acfb65915cc562aa4f",
"assets/assets/images/personal/amg_gt3_wheel/image_9.png": "713cab84a42380c7313705a6f3c1f829",
"assets/assets/images/personal/amg_gt3_wheel/image_12.png": "aa033487654a91047185d0c828b30d72",
"assets/assets/images/personal/amg_gt3_wheel/image_11.png": "d49d3f6686da7f2a12e1d94e31179f11",
"assets/assets/images/personal/amg_gt3_wheel/image_7.png": "67a144e0b94e99d4908b65dd7ed58528",
"assets/assets/images/personal/amg_gt3_wheel/image_6.png": "ebf34bc190ec381ec3a94be9dfdb3134",
"assets/assets/images/personal/amg_gt3_wheel/image_10.png": "4def5f4c15fbf03e205fc0d64a456dbb",
"assets/assets/images/personal/project_lemans/image_5.png": "1ba94bfb903da87f998852116f91f971",
"assets/assets/images/personal/project_lemans/image_14.png": "c7fc1ecd35b7ab119e19c5ebd410ddbd",
"assets/assets/images/personal/project_lemans/thumbnail.png": "d682b5f28176bc51a48473d9ee9282de",
"assets/assets/images/personal/project_lemans/image_20.png": "f5b124b668aa52115cc10ed3cf7039e8",
"assets/assets/images/personal/project_lemans/image_8.png": "7cbfa3c4b2c15102ac95f5e50535588e",
"assets/assets/images/personal/project_lemans/image_21.png": "2ebc310977024ff8acd5e25714c88905",
"assets/assets/images/personal/project_lemans/image_25.png": "080b88f44f625d2e02aead668ab7d0bd",
"assets/assets/images/personal/project_lemans/image_18.png": "d095f5bdde0a82aa5a178d0017c77c8d",
"assets/assets/images/personal/project_lemans/image_2.png": "ec1e7a46a7be599a8621090afd7805eb",
"assets/assets/images/personal/project_lemans/image_19.png": "eb196681dcea7566754572a8014f8744",
"assets/assets/images/personal/project_lemans/image_17.png": "fd5313faebae2696588b60dfe6244f4d",
"assets/assets/images/personal/project_lemans/image_16.png": "bab019e0a434a2069adca112b89f1718",
"assets/assets/images/personal/project_lemans/video_1.mp4": "74aefefed85314d9ca4953b1bcab457e",
"assets/assets/images/personal/project_lemans/image_3.png": "a86fb53ea8f8cd3547f000cb6be128df",
"assets/assets/images/personal/project_lemans/image_4.png": "937eb8e4f165ec31b1b57dcad84ed75e",
"assets/assets/images/personal/project_lemans/image_13.png": "b7285c16066949b922a0a2caa72a98b5",
"assets/assets/images/personal/project_lemans/image_23.png": "624555ac78ac60247dfde6f8853fab2c",
"assets/assets/images/personal/project_lemans/image_15.png": "8fa47f5b5464f789159f9d91754d4c80",
"assets/assets/images/personal/project_lemans/image_1.png": "d5517ae35d036751fbcf0ce1813b2b06",
"assets/assets/images/personal/project_lemans/image_26.png": "be7bdc433d4a0bcdc53222275900e976",
"assets/assets/images/personal/project_lemans/image_22.png": "b4170f9a287643cc306e2c0877a8e3e6",
"assets/assets/images/personal/project_lemans/image_9.png": "cc1c6c2d23cfb6e11813708e5093ac8a",
"assets/assets/images/personal/project_lemans/image_24.png": "d24031c759106911185c20ac315fbf77",
"assets/assets/images/personal/project_lemans/image_12.png": "d21c7dcef0dda9a8d179b88fdd8014e1",
"assets/assets/images/personal/project_lemans/image_11.png": "3bdc1a7a0106a80d9365adc607fe8141",
"assets/assets/images/personal/project_lemans/image_7.png": "7cd6385c19e73aacf6f13b4037fa0c9e",
"assets/assets/images/personal/project_lemans/image_6.png": "d8c8dd7d630c3aae84ef7d01b25a2b34",
"assets/assets/images/personal/project_lemans/image_10.png": "3c9a3a77f0dc169713de6b5f37f5273d",
"assets/assets/images/personal/handroid/image_5.png": "31f8b2146e275b2f10046adbfb59ab30",
"assets/assets/images/personal/handroid/thumbnail.png": "54c99eb16f234ab3d6256e178ed03588",
"assets/assets/images/personal/handroid/image_8.png": "d89513c829fac4fab3f36fa7aac6f805",
"assets/assets/images/personal/handroid/image_2.png": "2f856d27a4f780cce71f5080fdd86e36",
"assets/assets/images/personal/handroid/video_1.mp4": "4b87d0241051f1935e669afba8607fcd",
"assets/assets/images/personal/handroid/image_3.png": "263a9ad39c61672b8d0b22823cb6d1d0",
"assets/assets/images/personal/handroid/image_4.png": "50f3cdeaa26dcb9bd66714c809c13789",
"assets/assets/images/personal/handroid/image_13.png": "939305f1d65c86cf199eb792e3225e85",
"assets/assets/images/personal/handroid/image_1.png": "e0d0c01fd406bf18024640be73d7d1bd",
"assets/assets/images/personal/handroid/image_9.png": "f1b18f27d86314b70a088a41bc5c6561",
"assets/assets/images/personal/handroid/image_12.png": "d8e002a0a8cfa20a42c7c534c5d15a89",
"assets/assets/images/personal/handroid/image_11.png": "b732efab042dbc547e5957cfa66da7f2",
"assets/assets/images/personal/handroid/image_7.png": "b0713487620b8b7ab277d8bd1bf477f6",
"assets/assets/images/personal/handroid/image_6.png": "3a6218582579cf3fda9e4f62a7791e8f",
"assets/assets/images/personal/handroid/image_10.png": "89909f5f6cd28d8c80d779b9dcbe94cd",
"assets/assets/images/personal/android_calculator/thumbnail.png": "a2460f3198bc3f8d07b1ccd197ae7671",
"assets/assets/images/personal/android_calculator/video_1.mp4": "73d5e457e796629991cc0854dd3d0030",
"assets/assets/images/personal/android_calculator/image_1.png": "ef0d51a52f5e5e2ce12c65b68fe6ee27",
"assets/assets/images/personal/xbox_head_tracking/image_5.png": "652b2ddc33eed34c9b4f00e3c761a2a9",
"assets/assets/images/personal/xbox_head_tracking/thumbnail.png": "1937eb7b3d3297af0b9acf40b3c79b89",
"assets/assets/images/personal/xbox_head_tracking/video_3.mp4": "cb038b15c811fb00afee760a17a152cd",
"assets/assets/images/personal/xbox_head_tracking/video_2.mp4": "837e370232d5418620d789aba1baf8b0",
"assets/assets/images/personal/xbox_head_tracking/image_2.png": "423a26525af0e859f1e9de8a902a6293",
"assets/assets/images/personal/xbox_head_tracking/video_1.mp4": "f21365d9503174f30d115cbfb573219a",
"assets/assets/images/personal/xbox_head_tracking/image_3.png": "b1eacb9eb98c32e5d444f4e434c850a0",
"assets/assets/images/personal/xbox_head_tracking/image_4.png": "572744157df30faa52263a2015262953",
"assets/assets/images/personal/xbox_head_tracking/image_1.png": "514b361a94ce3573271c3785be27aaf1",
"assets/assets/images/personal/macro_pad/thumbnail.png": "388eecb266436d3ef019bbbcc80fbde3",
"assets/assets/images/personal/macro_pad/image_2.png": "95e8d789c3bc6b6d6c35fea793c2b989",
"assets/assets/images/personal/macro_pad/image_1.png": "82af770b2c3782f4e8472687c6575028",
"assets/assets/images/personal/apple_charging_station/image_5.png": "a7f75a245787e9ec85ffb2c4ec441132",
"assets/assets/images/personal/apple_charging_station/thumbnail.png": "2b9e7dbfca9d0c46c755500d1ea2f73c",
"assets/assets/images/personal/apple_charging_station/image_2.png": "a2d2a200f8e01578df35d0b909b233e6",
"assets/assets/images/personal/apple_charging_station/image_3.png": "0d498dfd4f7e2580a0dad8e673ce8bfe",
"assets/assets/images/personal/apple_charging_station/image_4.png": "689903d5aba7f7e1c941e16a6f8d205f",
"assets/assets/images/personal/apple_charging_station/image_1.png": "bad7543ed70910fd01dbb50e466026aa",
"assets/assets/images/personal/apple_charging_station/image_7.png": "8bedbd45de308a9b10f879cca2652251",
"assets/assets/images/personal/apple_charging_station/image_6.png": "999d0a5a9a64acb4fc1d4ff37cc04ec8",
"assets/assets/images/personal/swe_632_lottery/image_5.png": "c8f4951decd1a0ce98a00ce241770fa3",
"assets/assets/images/personal/swe_632_lottery/thumbnail.png": "7bd5b73160e7c77abababbbcc1dd8d32",
"assets/assets/images/personal/swe_632_lottery/image_2.png": "ec58244d80412c75196b147bc104b052",
"assets/assets/images/personal/swe_632_lottery/image_3.png": "553343c40ebb506bb49fe404add40ee4",
"assets/assets/images/personal/swe_632_lottery/image_4.png": "24f5f6d05dfae93e0dcc4c6884e7091a",
"assets/assets/images/personal/swe_632_lottery/image_1.png": "a438aee8e5292046e0f6302e43e3de0e",
"assets/assets/images/personal/swe_632_lottery/image_7.png": "e2dca2e6fe912827c7b0c6fe5508e3e5",
"assets/assets/images/personal/swe_632_lottery/image_6.png": "394ccdb2979bf19e2d74ccdfef30d60b",
"assets/assets/images/personal/switch_speaker/image_5.png": "68df731be638dfe7478f9552dd954f94",
"assets/assets/images/personal/switch_speaker/thumbnail.png": "dd6b931620a1df40d45a0b89b806ee71",
"assets/assets/images/personal/switch_speaker/image_2.png": "9e7bea33532686f640a4df608f4a52ba",
"assets/assets/images/personal/switch_speaker/image_3.png": "ccc5bd5880b71ff7aae5561bce6ec84b",
"assets/assets/images/personal/switch_speaker/image_4.png": "6e9f6112c33d34db7cf24074bedb8ae5",
"assets/assets/images/personal/switch_speaker/image_1.png": "58f0c81898da64a28727e994e4e457ed",
"assets/assets/images/personal/switch_speaker/image_6.png": "939cd0fbd3dfbb56378dc94ad2483568",
"assets/assets/images/professional/am3_lab/video_9.mp4": "ef94275f2b159205aa4cd4c8be20ae40",
"assets/assets/images/professional/am3_lab/image_5.png": "baafab7c3689b23e06bf3720dd148856",
"assets/assets/images/professional/am3_lab/thumbnail.png": "c59b79a881da1cf7714df5e87ea25195",
"assets/assets/images/professional/am3_lab/video_6.mp4": "b83d1d7b0891e6892e72b2adac436e2f",
"assets/assets/images/professional/am3_lab/video_3.mp4": "3f4b7568b8b91299ab042b522cf6bec5",
"assets/assets/images/professional/am3_lab/video_2.mp4": "05d518bde2965aa641775a2828721a6f",
"assets/assets/images/professional/am3_lab/image_2.png": "7530c325766da32e5796f1cd40d51aec",
"assets/assets/images/professional/am3_lab/video_1.mp4": "1ede8af5ab8f9e17caf3bbf01de83c2b",
"assets/assets/images/professional/am3_lab/video_8.mp4": "5fdb39bb0bc68030ddf24cad485cf3d5",
"assets/assets/images/professional/am3_lab/image_3.png": "81927072ffc2aa49e1780e81392be16a",
"assets/assets/images/professional/am3_lab/video_7.mp4": "1cafb465e1adcedd9417db3e0dd3ae37",
"assets/assets/images/professional/am3_lab/video_11.mp4": "3ba7e77370dae7347388ff39057a3138",
"assets/assets/images/professional/am3_lab/image_4.png": "f3ae05892a39b8a58bc1adf428067296",
"assets/assets/images/professional/am3_lab/video_4.mp4": "19e56665afa1e76d6d2faa2613a95e2e",
"assets/assets/images/professional/am3_lab/video_5.mp4": "3a3ff2537839b6a311332f9631c5cc4e",
"assets/assets/images/professional/am3_lab/image_1.png": "bad273dd664f0dc8a2dfc9d7f21b5fe4",
"assets/assets/images/professional/am3_lab/video_10.mp4": "2bbb6471d76c091e076eb3ebee7ef825",
"assets/assets/images/professional/am3_lab/logo.png": "bf7bfe9e2766b0388b9dfce36f8af6d8",
"assets/assets/images/professional/am3_lab/image_7.png": "f6fe30a0d8fa121a2d37a70f46f60cc1",
"assets/assets/images/professional/am3_lab/image_6.png": "ec3ff95577da75496865253336b538a2",
"assets/assets/images/professional/atlantic_insurance/thumbnail.png": "1a925e94e95e28f24bea33d324a53aa6",
"assets/assets/images/professional/atlantic_insurance/image_1.png": "5f07f56cec8e846458ff556bf4275df3",
"assets/assets/images/professional/atlantic_insurance/logo.png": "e95fe8aed40f6ad7a9ad0874ca34f4f7",
"assets/assets/images/professional/ambots/video_9.mp4": "118f31dd3490e813b19f85618e29ad01",
"assets/assets/images/professional/ambots/image_5.png": "771ea63f832e42e98fd1dd4f8affeb00",
"assets/assets/images/professional/ambots/thumbnail.png": "31dbf2aa4533d9de35e2085064a09447",
"assets/assets/images/professional/ambots/video_6.mp4": "3314acbfa1aac3e6383179043acbac0f",
"assets/assets/images/professional/ambots/video_3.mp4": "4713879b66ee29d3dfef9a058348037d",
"assets/assets/images/professional/ambots/image_8.png": "708f436c7abdc3fd804c5fe622d50193",
"assets/assets/images/professional/ambots/video_2.mp4": "73e0d2f2e11c7146d933dd8c317deeb1",
"assets/assets/images/professional/ambots/image_2.png": "2eb4203c2cda7056450c4bc8885b6d9f",
"assets/assets/images/professional/ambots/video_1.mp4": "0ebb82492534d22723d5d994a9a9c8c0",
"assets/assets/images/professional/ambots/video_8.mp4": "6e04575882b8ce15a737201fd17faa34",
"assets/assets/images/professional/ambots/image_3.png": "7c55d3441c1fcf478b990d62b7da65cb",
"assets/assets/images/professional/ambots/video_7.mp4": "0a52553dfd8342250a4aaa447c818632",
"assets/assets/images/professional/ambots/image_4.png": "5f9d166ab6aa972408bfdaeb2a020b8c",
"assets/assets/images/professional/ambots/video_4.mp4": "8ca91c51536da23d7de92b4e7d9a35cb",
"assets/assets/images/professional/ambots/video_5.mp4": "cbf3b0e214808331f5b803aefe22be83",
"assets/assets/images/professional/ambots/image_1.png": "a00ab587c0f195bb28e8655d49284ca7",
"assets/assets/images/professional/ambots/image_9.png": "cd3c985096a69179afdce2077ca8e0a6",
"assets/assets/images/professional/ambots/image_12.png": "0d1422fa7c85e2a1dc0150ee9f5d0154",
"assets/assets/images/professional/ambots/video_10.mp4": "ddee026980cc5b014cc8835d01867aa3",
"assets/assets/images/professional/ambots/image_11.png": "dfa9deb9f16734af959f51b9642fd7e3",
"assets/assets/images/professional/ambots/logo.png": "d6c325ed11cea70feb0923fd52be4e0f",
"assets/assets/images/professional/ambots/image_7.png": "7d418118a30cd0d3e2e9daceefba950d",
"assets/assets/images/professional/ambots/image_6.png": "00930e20c85eb343c5458cec4cedbcc5",
"assets/assets/images/professional/ambots/image_10.png": "b4e899f94159886acba62837a0661340",
"assets/assets/images/home/professional.png": "1a925e94e95e28f24bea33d324a53aa6",
"assets/assets/images/home/uark_logo.png": "bf7bfe9e2766b0388b9dfce36f8af6d8",
"assets/assets/images/home/gmu_logo.png": "8add7dc6220f1eab3f36fa985a387239",
"assets/assets/images/home/personal.png": "1d4cb269a4df5468910fb31005909475",
"assets/assets/images/home/profile_light.jpg": "1a8651ad1e0e00efc60989aac9142ef7",
"assets/assets/images/home/profile_dark.jpg": "7363005500d81dd75faefacb451ac27b",
"assets/assets/images/icons/github.png": "3e88a0de8cc52551201808266651cfaa",
"assets/assets/images/icons/resume_builder.png": "307e923542d4020ea48f62323445f85e",
"assets/assets/images/icons/thingiverse.png": "9092b42103f22239610c63df0c5cc9c0",
"assets/assets/images/icons/linkedin.png": "2e88efdd4a48a1f2a3d096768fa5cdd0",
"assets/assets/json/projects.json": "77f2ad0cfeb0be6e5b1fe4da4ee0ff0c",
"assets/assets/json/professional_experience.json": "a5a0cb8afa22200ae9009be7fc9dec85",
"assets/AssetManifest.bin.json": "13f769faad44243280ef7e0ef4967184",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/NOTICES": "7bfaac7ef160b323f689f2817c3e4a38",
"assets/AssetManifest.json": "b1f0dc397389913263083ed367efccbb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "f2163b9d4e6f1ea52063f498c8878bb9",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"favicon.png": "baf227a07cf56a61f1a579027a3ab7ed",
"main.dart.js": "04d7c3008f6db77261acb378776011a6",
"version.json": "c9d9747bcfb04e5ba873325d79534153",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"icons/Icon-512.png": "c6e9e9241cba806f198521f77ebf1446",
"icons/Icon-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-maskable-192.png": "8403e61d84a145213b51a74f6a04f488",
"icons/Icon-maskable-512.png": "c6e9e9241cba806f198521f77ebf1446"};
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
