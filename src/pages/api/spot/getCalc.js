'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getCalc(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let anzahl = params.find(element => element.label == 'Anzahl')

    let sql = 'SELECT top 1 Anzahl = ' + anzahl.value + ' ,* FROM fakt.spot WHERE 1=1 '
    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        sql += " AND ([Form_DE] = '" + form + "' OR [Form_EN] = '" + form + "')"
      }
      if (element.label == 'Typ') {
        let typ = element.value
        sql += " AND ([Typ_Gehaeuse_DE] = '" + typ + "' OR [Typ_Gehaeuse_EN] = '" + typ + "')"
      }
      if (element.label == 'Gehäusefarbe') {
        let gehaeusefarbe = element.value
        sql += " AND ([Farbe_DE] = '" + gehaeusefarbe + "' OR [Farbe_EN] = '" + gehaeusefarbe + "')"
      }

      //LED
      if (element.label == 'Ausführung') {
        let farbkanal = element.value
        sql += " AND ([Farbkanal] = '" + farbkanal + "' OR [Farbkanal] = '" + farbkanal + "')"
      }

      if (element.label == 'Lichtfarbe') {
        let lichtfarbe = element.value
        sql += " AND ([Lichtfarbe] = '" + lichtfarbe + "' OR [Lichtfarbe] = '" + lichtfarbe + "')"
      }
      if (element.label == 'Leistung') {
        let leistung = element.value
        sql += " AND ([Leistung] = '" + leistung + "' OR [Leistung] = '" + leistung + "')"
      }
      if (element.label == 'Abstrahlwinkel') {
        let abstrahlwinkel = element.value
        sql += " AND ([Abstrahlwinkel] = '" + abstrahlwinkel + "' OR [Abstrahlwinkel] = '" + abstrahlwinkel + "')"
      }
      //Treiber
      if (element.label == 'Treiber') {
        let treiber = element.value
        sql += " AND ([Treiber_DE] = '" + treiber + "' OR [Treiber_EN] = '" + treiber + "')"
      }

      if (element.label == 'Ansteuerung') {
        let ansteuerung = element.value
        sql += " AND ([Ansteuerung2_DE] = '" + ansteuerung + "' OR [Ansteuerung2_EN] = '" + ansteuerung + "')"
      }

      if (element.label == 'Anschlussleitung') {
        let ausfuehrung = element.value
        sql += " AND ([Ausführung_DE] = '" + ausfuehrung + "' OR [Ausführung_EN] = '" + ausfuehrung + "')"
      }
    })

    sql += ' ORDER BY 1'

    const result = await query(sql)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
