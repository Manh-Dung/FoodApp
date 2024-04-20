var fs = require('fs');
var files = fs.readdirSync('../assets/svgs');

//generate svg
var svg = ''
files.forEach(e => {
    svg += `String ${e.replace('.svg', '')} = svg + \'${e}\'; \n`;
});
svg = `class _SVGImage {
    static const String svg = 'assets/svgs/';
        ${svg}
    }\n
    `
//generate image
var files = fs.readdirSync('../assets/images');
var image = ''
files.forEach(e => {
    image += `String ${e.replace('.png', '')} = images + \'${e}\'; \n`;
});
image = `class _AssetsImage {
    static const String images = 'assets/images/';
        ${image}
    }\n\n
    `


//generate String
var text = fs.readFileSync("../lib/x_res/language/en_US.dart", 'utf8');
text = text.split('\'').join('"');
text = text.replace(';', '')
var arr = text.split(' = ')
const json = JSON.parse(arr[1]);
var stringJson = '';
Object.keys(json).forEach(e => {
    stringJson += `String ${e} = '${e}'.tr; \n`;
});

stringJson = `class _String {
    ${stringJson}
}\n\n`

var result = `import 'package:get/get.dart';

class XR {
  _String string = _String();
  _AssetsImage assetsImage = _AssetsImage();
  _SVGImage svgImage = _SVGImage();
}\n\n ${image + svg + stringJson}
`
//write
fs.writeFile('../lib/x_res/x_r.dart', result, (err) => {
    if (err) throw err;
})


/// run `node PATH asset.js`