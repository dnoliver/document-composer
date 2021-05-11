let str = ''

process.stdin
  .on('data', data => {
    str += data.toString()
  })
  .on('end', () => {
    // Select all links that have url targets
    const matches = str.match(/\[([^\[\]]+)\]\(http([^)]+)\)/gm)

    if (matches) {
      const citationsCollection = []
      let citationIndex = 1

      for (const i in matches) {
        const match = matches[i]
        const parts = match.match(/\[([^\[\]]+)\]\((http[^)]+)\)/)
        if (parts) {
          var citationObject = {
            name: parts[1],
            link: parts[2]
          }
          const oldCitation = citationsCollection.find(x => x.link === citationObject.link)
          if (typeof oldCitation === 'undefined') {
            citationObject.index = citationIndex
            citationsCollection.push(citationObject)
            str = str.replace(match, `${match} [[${citationObject.index}]](#citations)`)
            citationIndex = citationIndex + 1
          } else {
            str = str.replace(match, `${match} [[${oldCitation.index}]](#citations)`)
          }
        }
      }

      let citations = '# Citations\n\n'
      citationsCollection.forEach(function (o) {
        citations += `* [${o.index}] "${o.name}": [${o.link}](${o.link})\n`
      })

      console.log(str)
      console.log(citations)
    } else {
      // No Citations
      console.log(str)
    }
  })
