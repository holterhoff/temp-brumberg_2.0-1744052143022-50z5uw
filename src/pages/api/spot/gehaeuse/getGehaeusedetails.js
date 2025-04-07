'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getGehaeusedetails(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `
    SELECT distinct
    bezeichnung_gehaeuse_de,
    bezeichnung_gehaeuse_en,
    artikelnummer_gehaeuse as Artikelnummer,
    produktbeschreibung_gehaeuse_de,
    produktbeschreibung_gehaeuse_en,
    preis_gehaeuse as Preis,
    seo_url_gehaeuse_de as SEO_Url_DE,
    datenblatt_gehaeuse_de as Datenblatt_DE

    FROM spot WHERE 1=1
    `
    params.forEach(element => {
      if (element.label == 'Form') {
        let form = element.value
        query += " AND (form_de = '" + form + "' OR form_en = '" + form + "')"
      }
      if (element.label == 'Einbautiefe') {
        let einbautiefe = element.value
        query += " AND einbautiefe = '" + einbautiefe + "'"
      }
      if (element.label == 'Typ') {
        let typ = element.value
        query += " AND (typ_gehaeuse_de = '" + typ + "' OR typ_gehaeuse_en = '" + typ + "')"
      }
      if (element.label == 'Gehäusefarbe') {
        let gehaeusefarbe = element.value
        query += " AND (farbe_de = '" + gehaeusefarbe + "' OR farbe_en = '" + gehaeusefarbe + "')"
      }
    })

    query += ' ORDER BY 1'

    const result = await sql(query)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
