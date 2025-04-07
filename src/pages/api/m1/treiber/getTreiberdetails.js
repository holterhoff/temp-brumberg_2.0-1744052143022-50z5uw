'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getTreiberdetails(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `
    SELECT distinct
    bezeichnung_treiber_de as Bezeichnung_DE,
    bezeichnung_treiber_en as Bezeichnung_EN ,
    artikelnummer_treiber as Artikelnummer,
    produktbeschreibung_treiber_de as Produktbeschreibung_DE,
    produktbeschreibung_treiber_en as Produktbeschreibung_EN,
    preis_treiber as Preis,
    seo_url_treiber_de as SEO_Url_DE,
    seo_url_treiber_en as SEO_Url_EN

    FROM m1 WHERE 1=1

    `

    params.forEach(element => {
      if (element.label == 'Treiber') {
        let treiber = element.value
        query += " AND (treiber_de = '" + treiber + "' OR treiber_en = '" + treiber + "')"
      }

      if (element.label == 'Ansteuerung') {
        let ansteuerung = element.value
        query += " AND (ansteuerung2_de = '" + ansteuerung + "' OR ansteuerung2_en = '" + ansteuerung + "')"
      }

      if (element.label == 'Anschlussleitung') {
        let ausfuehrung = element.value
        query += " AND (ausfuehrung_de = '" + ausfuehrung + "' OR ausfuehrung_en = '" + ausfuehrung + "')"
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
