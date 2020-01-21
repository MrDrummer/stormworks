const fs = require("fs")
const luamin = require("luamin")

const files = fs.readdirSync("./src/")
if (files.length > 0) {
  for (const file of files) {
    const fileContents = fs.readFileSync("./src/" + file, "utf8")
    // console.log("fileContents :", fileContents)
    const minified = luamin.minify(fileContents)
    // console.log("minified :", minified)
    fs.writeFileSync("./dist/" + file, minified)
  }
}
