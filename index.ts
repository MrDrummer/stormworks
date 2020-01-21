import * as fs from "fs"
import luamin from "luamin"

const files = fs.readdirSync("./src/")
if (files.length > 0) {
  console.log("SUCCESS!!", files)
  for (const file of files) {
    const fileContents = fs.readFileSync("./src/" + file, "utf8")
    // console.log("fileContents :", fileContents)
    const minified = luamin.minify(fileContents)
    // console.log("minified :", minified)
    fs.writeFileSync("./dist/" + file, minified)
  }
}
