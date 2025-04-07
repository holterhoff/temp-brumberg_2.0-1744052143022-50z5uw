import React, { useState, useEffect, useMemo } from 'react'

const defaultKep = {
  KEP_ID: '7411152',
  FIGUR_POS: 4,
  FIGUR: 'FIGUR Z',
  FIGUR_INDEX: 'Z',
  PRODUKT_ID: 74,
  KEP_PRO_INDEX: 11,
  KEP_GTR_INDEX: 15,
  KEP_OPT_INDEX: 2,
  HERSTELLER: 'BRUMBERG',
  PRODUKT: 'BIRO40',
  LICHTRICHTUNG: 'DIREKT INDIREKT',
  SCHUTZART: 'IP20',
  GEHAEUSEFARBE: 'WEISS',
  MONTAGEART: 'EINBAU',
  MONTAGEART_KEP: 'EINBAU',
  LICHTFARBE: '6500 K',
  LICHTFARBE_DIREKT: '6.500 K',
  LICHTFARBE_INDIREKT: 'RGBW',
  LICHTSTROM: 'HIGH OUTPUT',
  CRI: 'RA>90',
  ANSTEUERUNG: 'SCHALTBAR',
  POLE: '3 POL',
  OPTISCHES_SYSTEM: 'PRISMATISCH',
  MIN: 840,
  PROFIL_TYP: 'PROFIL ANBAU',
  PRO_BASE_ID: '74P011',
  LICHTEINSATZ_TYP: 'LICHTEINSATZ',
  GTR_BASE_ID: '74G1603',
  OPTIK_TYP: 'OPTIK',
  OPT_BASE_ID: '74OP20',
  ENDDECKEL_TYP: 'ENDDECKEL',
  KSED_ID: '74PZK01100',
  VERBINDER_TYP: 'VERBINDER',
  VERB_ID: '74PZV01100',
  BEFESTIGUNGS_TYP: 'KEINE',
  BEFE_ID: 'KEINE',
  EINSPEISER_TYP: 'KEINE',
  ESPE_ID: 'KEINE',
  EULUM: 'DIREKT 6500 K RA>90 PRISMATISCH',
  BERECHNUNGSLAENGE: 1000,
  LUMEN_M_DIREKT: 0,
  LUMEN_M_INDIREKT: 0,
  LUMEN_M_GESAMT: 2400,
  LEISTUNG_M_GESAMT: 40,
  LUMEN_PRO_WATT_M: 0,
  EULUMDAT_BASIS: 'DIREKT_RA90_PRISMATISCH_1000.LDT',
  HEADERBILD: 'Z_ANBAU_W.jpg',
  PRODUKTBILD: 'ANBAU_DI_PRISMATISCH_6500K_NULL_WEISS.jpg',
  SKIZZE: 'FIGUR_Z.png',
  POLARDIAGRAMM: 'DIREKT_6500_K_null_PRISMATISCH.jpg',
  SVG_IMAGE: 'SVG_7411152.svg',
  SSC_INPUT_1: '#SSC!_*INPUT1#',
  SSC_INPUT_2: '#SSC!_*INPUT2#',
  SSC_INPUT_3: '#SSC!_*INPUT3#',
  SSC_INPUT_4: '#SSC!_*INPUT4#',
  SSC_INPUT_5: '#SSC!_*INPUT5#',
  SSC_INPUT_6: '#SSC!_*INPUT6#',
  SSC_INPUT_7: '#SSC!_*INPUT7#',
  SSC_INPUT_8: '#SSC!_*INPUT8#',
  SSC_INPUT_9: '#SSC!_*INPUT9#',
  SSC_INPUT_10: '#SSC!_*INPUT10#!*SCHALTBAR',
  KURZBESCHREIBUNG: 'LED-Profilsystem Anbau direkt strahlend',
  MATERIAL: 'Aluminium / Acryl',
  FARBE: 'weiss',
  PROFILQUERSCHNITT: '40mm x 75mm',
  NETTOGEWICHT_M: 2.281,
  KONFORMITAET: 'CE, UKCA',
  FARBTEMPERATUR_DIREKT: '6.500 K',
  FARBTEMPERATUR_INDIREKT: 'RGBW',
  LICHTFARBE_FT: 'tageslichtweiss',
  FARBTOLERANZ: 'McAdam-Step 3',
  FARBWIEDERGABE: 'CRI > 90',
  LEUCHTENOPTIK: 'Abdeckung mikroprismatisch',
  REFLEKTOR: 'Ohne',
  ABSTRAHLWINKEL: '80°',
  BLENDUNGSBEWERTUNG: 'UGR < 19',
  LICHTVERTEILUNG: 'symmetrisch',
  FARBTEMPERATUR_EINSTELLBAR: 'Nein',
  SPANNUNGSART: 'AC',
  AC_NENNSPANNUNG: '230 V',
  FREQUENZ: '50 Hz',
  LEUCHTMITTEL: 'LED',
  SCHUTZKLASSE: 'I',
  SCHUTZART_RAUMSEITIG: 'IP20',
  LEBENSDAUER_L70B50_25: '60.000 h',
  LEBENSDAUER_L80B50_25: '60.000 h',
  DIMMBAR: 'nein',
  DIM_ANSTEUERUNG: 'schaltbar on/off',
  ANZAHL_VG_LICHTEINSATZ: 1,
  BASIS_TEXT:
    'Modulares LED-Profilleuchtensystem BIRO40 direkt strahlend, geeignet für die Decken- oder Wandaufbaumontage. System bestehend aus stranggepresstem Aluminiumprofil, Lichteinsätzen, Leuchtenoptiken und allem notwendigen Systemzubehör wie Enddekkappen und Profilverbinder. (Gesonderte Befestigungen entfallen bei der Anbauvariante.) Versetzte Form mit zwei Richtungswechseln, oft eingesetzt zur Überbrückung von Versprüngen in Decken- oder Wandbereichen (Figur in Form eines Z).',
  ERWEITERTER_TEXT:
    'Material: Aluminium / Acryl, Systemvariante: LED-Profilsystem Anbau direkt strahlend, Gehaeusefarbe: weiss, Profilquerschnitt: 40mm x 75mm, Leuchtenoptik: Abdeckung mikroprismatisch, Lichtaustritt: direkt, Abstrahlwinkel: 80°, Lichtverteilung: symmetrisch, Lichtfarbe: tageslichtweiss, Farbtemperatur direkt: 6.500 K, Farbtoleranz: McAdam-Step 3, Farbwiedergabeindex: CRI > 90, Blendbewertung: UGR < 19, Ansteuerung: schaltbar on/off, Leuchtmittel: LED, Betriebsspannung: 230 V AC 50 Hz, Schutzklasse: I, Schutzart: IP20, Lebensdauer L70 B50 bei 25C: 60.000 h, Lebensdauer L80 B50 bei 25C: 60.000 h, Effizienz: 0 lm/W',
  GROUP: '7411152-Z',
  BEFESTIGUNGSABSTAND_ABZUG: 300,
  BEFESTIGUNGSABSTAND_MAX: 1500,
  ESP_VERSATZ: 50,
  STROKE_FAKTOR: 1.4,
  STROKE_COLOR: 'black',
  STROKE_FILL: 'Seashell',
  DECKENAUSSCHNITT_BREITE: 45,
  DECKENAUSSCHNITT_TOLERANZ: 5,
  EINBAUTIEFE_MIN: 110,
  INSTALLATIONSTYP: 'Pendelausführung mittels höhenverstellbarer Stahlseile (max. 3,0 m)'
}

const LightConfigurator = props => {
  const [kep, setKep] = useState(defaultKep)
  const [configID, setConfigID] = useState(props.id || '7436275-O-2985-1520-4185')
  const [shape, setShape] = useState('RECHTECK')
  const [lengthA, setLengthA] = useState(1000)
  const [lengthB, setLengthB] = useState(500)
  const [lengthC, setLengthC] = useState(700)
  const [lengthD, setLengthD] = useState(700)

  // Zusätzliche Zustände (z. B. für Treiberzahlen) – bleiben erhalten, falls benötigt
  const [anzahlGTR, setAnzahlGTR] = useState(0)
  const [anzahlPRO, setAnzahlPRO] = useState(0)
  const [anzahlOPT, setAnzahlOPT] = useState(0)
  const [anzahlVGGtrA, setAnzahlVGGtrA] = useState(0)
  const [anzahlVGGtrB, setAnzahlVGGtrB] = useState(0)
  const [anzahlVGGtrC, setAnzahlVGGtrC] = useState(0)
  const [anzahlVGGtrD, setAnzahlVGGtrD] = useState(0)

  // API-Aufruf (falls props.id genutzt wird)
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`/api/biro40/getKepDataSheet?id=${configID}`)
        if (!response.ok) throw new Error('Fehler beim Abrufen der Daten')
        const result = await response.json()
        const apiData = result[0]
        if (apiData) {
          setKep(mapApiDataToKep(apiData))
        }
      } catch (error) {
        console.error('API-Fehler:', error)
      }
    }
    fetchData()
  }, [configID])

  const mapApiDataToKep = apiData => {
    if (!apiData) return {}
    return {
      KEP_ID: apiData.kep_id,
      FIGUR_POS: apiData.figur_pos,
      FIGUR: apiData.figur,
      FIGUR_INDEX: apiData.figur_index,
      PRODUKT_ID: apiData.produkt_id,
      KEP_PRO_INDEX: apiData.kep_pro_index,
      KEP_GTR_INDEX: apiData.kep_gtr_index,
      KEP_OPT_INDEX: apiData.kep_opt_index,
      HERSTELLER: apiData.hersteller,
      PRODUKT: apiData.produkt,
      LICHTRICHTUNG: apiData.lichtrichtung,
      SCHUTZART: apiData.schutzart,
      GEHAEUSEFARBE: apiData.gehaeusefarbe,
      MONTAGEART: apiData.montageart,
      MONTAGEART_KEP: apiData.montageart_kep,
      LICHTFARBE: apiData.lichtfarbe,
      LICHTFARBE_DIREKT: apiData.lichtfarbe_direkt,
      LICHTFARBE_INDIREKT: apiData.lichtfarbe_indirekt,
      LICHTSTROM: apiData.lichtstrom,
      CRI: apiData.cri,
      ANSTEUERUNG: apiData.ansteuerung,
      POLE: apiData.pole,
      OPTISCHES_SYSTEM: apiData.optisches_system,
      MIN: apiData.min,
      PROFIL_TYP: apiData.profil_typ,
      PRO_BASE_ID: apiData.pro_base_id,
      LICHTEINSATZ_TYP: apiData.lichteinsatz_typ,
      GTR_BASE_ID: apiData.gtr_base_id,
      OPTIK_TYP: apiData.optik_typ,
      OPT_BASE_ID: apiData.opt_base_id,
      ENDDECKEL_TYP: apiData.enddeckel_typ,
      KSED_ID: apiData.ksed_id,
      VERBINDER_TYP: apiData.verbinder_typ,
      VERB_ID: apiData.verb_id,
      BEFESTIGUNGS_TYP: apiData.befestigungs_typ,
      BEFE_ID: apiData.befe_id,
      EINSPEISER_TYP: apiData.einspeiser_typ,
      ESPE_ID: apiData.espe_id,
      EULUM: apiData.eulum,
      BERECHNUNGSLAENGE: apiData.berechnungslaenge,
      LUMEN_M_DIREKT: apiData.lumen_m_direkt,
      LUMEN_M_INDIREKT: apiData.lumen_m_indirekt,
      LUMEN_M_GESAMT: apiData.lumen_m_gesamt,
      LEISTUNG_M_GESAMT: apiData.leistung_m_gesamt,
      LUMEN_PRO_WATT_M: apiData.lumen_pro_watt_m,
      EULUMDAT_BASIS: apiData.eulumdat_basis,
      HEADERBILD: apiData.headerbild,
      PRODUKTBILD: apiData.produktbild,
      SKIZZE: apiData.skizze,
      POLARDIAGRAMM: apiData.polardiagramm,
      SVG_IMAGE: apiData.svg_image,
      KURZBESCHREIBUNG: apiData.kurzbeschreibung,
      MATERIAL: apiData.material,
      FARBE: apiData.farbe,
      PROFILQUERSCHNITT: apiData.profilquerschnitt,
      NETTOGEWICHT_M: apiData.nettogewicht_m,
      KONFORMITAET: apiData.konformitaet,
      FARBTEMPERATUR_DIREKT: apiData.farbtemperatur_direkt,
      FARBTEMPERATUR_INDIREKT: apiData.farbtemperatur_indirekt,
      LICHTFARBE_FT: apiData.lichtfarbe_ft,
      FARBTOLERANZ: apiData.farbtoleranz,
      FARBWIEDERGABE: apiData.farbwiedergabe,
      LEUCHTENOPTIK: apiData.leuchtenoptik,
      REFLEKTOR: apiData.reflektor,
      ABSTRAHLWINKEL: apiData.abstrahlwinkel,
      BLENDUNGSBEWERTUNG: apiData.blendungsbewertung,
      LICHTVERTEILUNG: apiData.lichtverteilung,
      FARBTEMPERATUR_EINSTELLBAR: apiData.farbtemperatur_einstellbar,
      SPANNUNGSART: apiData.spannungsart,
      AC_NENNSPANNUNG: apiData.ac_nennspannung,
      FREQUENZ: apiData.frequenz,
      LEUCHTMITTEL: apiData.leuchtmittel,
      SCHUTZKLASSE: apiData.schutzklasse,
      SCHUTZART_RAUMSEITIG: apiData.schutzart_raumseitig,
      LEBENSDAUER_L70B50_25: apiData.lebensdauer_l70b50_25,
      LEBENSDAUER_L80B50_25: apiData.lebensdauer_l80b50_25,
      DIMMBAR: apiData.dimmbar,
      DIM_ANSTEUERUNG: apiData.dim_ansteuerung,
      ANZAHL_VG_LICHTEINSATZ: apiData.anzahl_vg_lichteinsatz,
      BASIS_TEXT: apiData.basistext,
      ERWEITERTER_TEXT: apiData.erweiterter_text,
      GROUP: apiData.group,
      BEFESTIGUNGSABSTAND_ABZUG: apiData.befestigungsabstand_abzug,
      BEFESTIGUNGSABSTAND_MAX: apiData.befestigungsabstand_max,
      ESP_VERSATZ: apiData.esp_versatz,
      STROKE_FAKTOR: apiData.stroke_faktor,
      STROKE_COLOR: apiData.stroke_color,
      STROKE_FILL: apiData.stroke_fill,
      DECKENAUSSCHNITT_BREITE: apiData.deckenausschnitt_breite,
      DECKENAUSSCHNITT_TOLERANZ: apiData.deckenausschnitt_toleranz,
      EINBAUTIEFE_MIN: apiData.einbautiefe_min,
      INSTALLATIONSTYP: apiData.installationstyp
    }
  }

  // Konfigurations-ID parsen und Schenkel-Längen setzen
  const parseConfigurationID = id => {
    const parts = id.split('-')
    if (parts.length < 3) return
    const shapeMap = { I: 'GERADE', L: 'L-FORM', U: 'U-FORM', Z: 'Z-FORM', O: 'RECHTECK' }
    setShape(shapeMap[parts[1]] || 'RECHTECK')
    setLengthA(parseInt(parts[2]) || 0)
    setLengthB(parts[3] ? parseInt(parts[3]) : 0)
    setLengthC(parts[4] ? parseInt(parts[4]) : 0)
    setLengthD(parts[5] ? parseInt(parts[5]) : 0)
  }

  useEffect(() => {
    parseConfigurationID(configID)
    document.title = `BIRO40 KONFIGURATIONS-ID: ${configID}`
  }, [configID])

  // Gesamtlänge berechnen
  const getSumLength = () => {
    if (shape === 'GERADE') return lengthA
    if (shape === 'L-FORM') return lengthA + lengthB
    if (['U-FORM', 'Z-FORM'].includes(shape)) return lengthA + lengthB + lengthC
    if (shape === 'RECHTECK') return lengthA + lengthB + lengthC + lengthD
    return 0
  }

  const sumLength = getSumLength()
  const totalLightFlux = calculateScaledValue(sumLength, kep.BERECHNUNGSLAENGE, kep.LUMEN_M_GESAMT)
  const totalPower = calculateScaledValue(sumLength, kep.BERECHNUNGSLAENGE, kep.LEISTUNG_M_GESAMT)
  const totalWeight = calculateScaledValue(sumLength, kep.BERECHNUNGSLAENGE, kep.NETTOGEWICHT_M, 2)

  const lightFluxA = calculateScaledValue(lengthA, kep.BERECHNUNGSLAENGE, kep.LUMEN_M_GESAMT)
  const lightFluxB = calculateScaledValue(lengthB, kep.BERECHNUNGSLAENGE, kep.LUMEN_M_GESAMT)
  const lightFluxC = calculateScaledValue(lengthC, kep.BERECHNUNGSLAENGE, kep.LUMEN_M_GESAMT)
  const lightFluxD = calculateScaledValue(lengthD, kep.BERECHNUNGSLAENGE, kep.LUMEN_M_GESAMT)

  const powerA = calculateScaledValue(lengthA, kep.BERECHNUNGSLAENGE, kep.LEISTUNG_M_GESAMT)
  const powerB = calculateScaledValue(lengthB, kep.BERECHNUNGSLAENGE, kep.LEISTUNG_M_GESAMT)
  const powerC = calculateScaledValue(lengthC, kep.BERECHNUNGSLAENGE, kep.LEISTUNG_M_GESAMT)
  const powerD = calculateScaledValue(lengthD, kep.BERECHNUNGSLAENGE, kep.LEISTUNG_M_GESAMT)

  const weightA = calculateScaledValue(lengthA, kep.BERECHNUNGSLAENGE, kep.NETTOGEWICHT_M, 2)
  const weightB = calculateScaledValue(lengthB, kep.BERECHNUNGSLAENGE, kep.NETTOGEWICHT_M, 2)
  const weightC = calculateScaledValue(lengthC, kep.BERECHNUNGSLAENGE, kep.NETTOGEWICHT_M, 2)
  const weightD = calculateScaledValue(lengthD, kep.BERECHNUNGSLAENGE, kep.NETTOGEWICHT_M, 2)

  let efficiency = 0
  if (parseFloat(totalPower) !== 0) {
    efficiency = (parseFloat(totalLightFlux) / parseFloat(totalPower)).toFixed(1)
  }
  const sumLengthM = (sumLength / 1000).toFixed(2)

  // SVG-Berechnungen
  const roundUpToNextThousand = val => Math.ceil(val / 1000) * 1000
  const getScaleDenominator = thousandVal => {
    const clamped = Math.min(thousandVal, 26000)
    const stepCount = Math.max(clamped / 1000, 1)
    return 6000 + 500 * (stepCount - 1)
  }

  const maxSchenkel = Math.max(lengthA, lengthB, lengthC, lengthD, 1000)
  const nextThousand = roundUpToNextThousand(maxSchenkel)
  const scaleDenom = getScaleDenominator(nextThousand)
  const maxScale = maxSchenkel / scaleDenom

  const startX = 50
  const startY = 50
  const strokeWidth = 150 * maxScale
  const arrowOffset = 50 * maxScale
  const labelOffset = strokeWidth * 2.5
  const legendMarginY = 250 * maxScale

  const calculatePoints = () => {
    let pts = [{ x: startX, y: startY }]
    if (shape === 'GERADE') {
      pts.push({ x: startX + lengthA, y: startY })
    } else if (shape === 'L-FORM') {
      pts.push({ x: startX + lengthA, y: startY })
      pts.push({ x: startX + lengthA, y: startY + lengthB })
    } else if (['U-FORM', 'Z-FORM'].includes(shape)) {
      pts.push({ x: startX + lengthA, y: startY })
      pts.push({ x: startX + lengthA, y: startY + lengthB })
      const lastX = shape === 'Z-FORM' ? startX + lengthA + lengthC : startX + lengthA - lengthC
      pts.push({ x: lastX, y: startY + lengthB })
    } else if (shape === 'RECHTECK') {
      pts.push({ x: startX + lengthA, y: startY })
      pts.push({ x: startX + lengthA, y: startY + lengthB })
      pts.push({ x: startX, y: startY + lengthB })
      pts.push({ x: startX, y: startY })
    }
    return pts
  }

  const points = calculatePoints()
  const polylinePoints = points.map(p => `${p.x},${p.y}`).join(' ')
  const minX = Math.min(...points.map(p => p.x)) - 600 * maxScale
  const minY = Math.min(...points.map(p => p.y)) - 600 * maxScale
  const maxX = Math.max(...points.map(p => p.x)) + 600 * maxScale
  const maxY = Math.max(...points.map(p => p.y)) + 600 * maxScale
  const extendedViewBoxHeight = maxY - minY + legendMarginY + arrowOffset + 50
  const viewBox = `${minX} ${minY} ${maxX - minX} ${extendedViewBoxHeight}`

  const labelPositions = points.slice(0, points.length - 1).map((p, index) => {
    const next = points[index + 1]
    const centerX = (p.x + next.x) / 2
    const centerY = (p.y + next.y) / 2
    let newX = centerX
    let newY = centerY
    switch (index) {
      case 0:
        newY = centerY - labelOffset
        break
      case 1:
        newX = centerX + labelOffset
        break
      case 2:
        newY = centerY + labelOffset
        break
      case 3:
        newX = centerX - labelOffset
        break
      default:
        break
    }
    return { x: newX, y: newY }
  })

  const arrowMarker = (
    <marker id='arrow' markerWidth='10' markerHeight='10' refX='0' refY='3' orient='auto' markerUnits='strokeWidth'>
      <path d='M0,0 L0,6 L9,3 z' fill='black' />
    </marker>
  )

  let endCapPoint = null
  if (shape === 'GERADE') {
    endCapPoint = points[1]
  } else if (shape === 'L-FORM') {
    endCapPoint = points[2]
  } else if (['U-FORM', 'Z-FORM'].includes(shape)) {
    endCapPoint = points[points.length - 1]
  }

  const orangeSquaresOnFigure = shape !== 'RECHTECK' && endCapPoint && (
    <g className='orange-squares'>
      <rect
        x={points[0].x - (strokeWidth * kep.STROKE_FAKTOR) / 2}
        y={points[0].y - (strokeWidth * kep.STROKE_FAKTOR) / 2}
        width={strokeWidth * kep.STROKE_FAKTOR}
        height={strokeWidth * kep.STROKE_FAKTOR}
        fill='orange'
      />
      <rect
        x={endCapPoint.x - (strokeWidth * kep.STROKE_FAKTOR) / 2}
        y={endCapPoint.y - (strokeWidth * kep.STROKE_FAKTOR) / 2}
        width={strokeWidth * kep.STROKE_FAKTOR}
        height={strokeWidth * kep.STROKE_FAKTOR}
        fill='orange'
      />
    </g>
  )

  const polylineElement_0 = (
    <polyline
      points={polylinePoints}
      fill='none'
      stroke={kep.STROKE_COLOR}
      strokeWidth={strokeWidth * kep.STROKE_FAKTOR}
    />
  )

  const pinkSquare_0 = shape === 'RECHTECK' && (
    <rect
      x={points[0].x - (strokeWidth * kep.STROKE_FAKTOR) / 2}
      y={points[0].y - (strokeWidth * kep.STROKE_FAKTOR) / 2}
      width={strokeWidth * kep.STROKE_FAKTOR}
      height={strokeWidth * kep.STROKE_FAKTOR}
      fill={kep.STROKE_COLOR}
    />
  )

  const polylineElement = (
    <polyline points={polylinePoints} fill='none' stroke={kep.STROKE_FILL} strokeWidth={strokeWidth} />
  )

  const pinkSquare = shape === 'RECHTECK' && (
    <rect
      x={points[0].x - strokeWidth / 2}
      y={points[0].y - strokeWidth / 2}
      width={strokeWidth}
      height={strokeWidth}
      fill={kep.STROKE_FILL}
    />
  )

  const arrowsElement = (
    <g className='arrows'>
      {points.slice(0, points.length - 1).map((p, index) => {
        const next = points[index + 1]
        const dx = next.x - p.x
        const dy = next.y - p.y
        const L = Math.sqrt(dx * dx + dy * dy)
        if (L === 0) return null
        const labelPos = labelPositions[index]
        const grayRadius = strokeWidth * 1.25
        let arrows = []
        if (index === 0) {
          arrows.push(
            <line
              key='arrow-A-left'
              x1={labelPos.x - grayRadius - arrowOffset}
              y1={labelPos.y}
              x2={p.x + strokeWidth / 2}
              y2={labelPos.y}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />,
            <line
              key='arrow-A-right'
              x1={labelPos.x + grayRadius + arrowOffset}
              y1={labelPos.y}
              x2={next.x - strokeWidth / 2}
              y2={labelPos.y}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />
          )
        } else if (index === 1) {
          arrows.push(
            <line
              key='arrow-B-top'
              x1={labelPos.x}
              y1={labelPos.y - grayRadius - arrowOffset}
              x2={labelPos.x}
              y2={p.y + strokeWidth / 2}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />,
            <line
              key='arrow-B-bottom'
              x1={labelPos.x}
              y1={labelPos.y + grayRadius + arrowOffset}
              x2={labelPos.x}
              y2={next.y - strokeWidth / 2}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />
          )
        } else if (index === 2) {
          if (shape === 'Z-FORM') {
            arrows.push(
              <line
                key='arrow-C-left'
                x1={labelPos.x - grayRadius - arrowOffset}
                y1={labelPos.y}
                x2={p.x + strokeWidth / 2}
                y2={labelPos.y}
                stroke='black'
                strokeWidth={strokeWidth * 0.1}
                markerEnd='url(#arrow)'
              />,
              <line
                key='arrow-C-right'
                x1={labelPos.x + grayRadius + arrowOffset}
                y1={labelPos.y}
                x2={next.x - strokeWidth / 2}
                y2={labelPos.y}
                stroke='black'
                strokeWidth={strokeWidth * 0.1}
                markerEnd='url(#arrow)'
              />
            )
          } else {
            arrows.push(
              <line
                key='arrow-C-left'
                x1={labelPos.x + grayRadius + arrowOffset}
                y1={labelPos.y}
                x2={p.x - strokeWidth / 2}
                y2={labelPos.y}
                stroke='black'
                strokeWidth={strokeWidth * 0.1}
                markerEnd='url(#arrow)'
              />,
              <line
                key='arrow-C-right'
                x1={labelPos.x - grayRadius - arrowOffset}
                y1={labelPos.y}
                x2={next.x + strokeWidth / 2}
                y2={labelPos.y}
                stroke='black'
                strokeWidth={strokeWidth * 0.1}
                markerEnd='url(#arrow)'
              />
            )
          }
        } else if (index === 3) {
          arrows.push(
            <line
              key='arrow-D-top'
              x1={labelPos.x}
              y1={labelPos.y + grayRadius + arrowOffset}
              x2={labelPos.x}
              y2={p.y - strokeWidth / 2}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />,
            <line
              key='arrow-D-bottom'
              x1={labelPos.x}
              y1={labelPos.y - grayRadius - arrowOffset}
              x2={labelPos.x}
              y2={next.y + strokeWidth / 2}
              stroke='black'
              strokeWidth={strokeWidth * 0.1}
              markerEnd='url(#arrow)'
            />
          )
        }
        return arrows
      })}
    </g>
  )

  const grayLabels = (
    <g className='gray-labels'>
      {labelPositions.map((pos, index) => (
        <g key={`label-${index}`}>
          <circle
            cx={pos.x}
            cy={pos.y}
            r={strokeWidth * 0.75}
            fill='gray'
            fillOpacity='0.9'
            stroke='black'
            strokeWidth='2'
          />
          <text
            x={pos.x}
            y={pos.y + strokeWidth * 0.4}
            fontSize={10 + strokeWidth}
            fill='white'
            stroke='black'
            strokeWidth={strokeWidth * 0.005}
            textAnchor='middle'
          >
            {['A', 'B', 'C', 'D'][index]}
          </text>
        </g>
      ))}
    </g>
  )

  const bluePoints = (
    <g className='blue-points'>
      {points.slice(0, points.length - 1).map((p, index) => {
        const next = points[index + 1]
        const dx = next.x - p.x
        const dy = next.y - p.y
        const L = Math.sqrt(dx * dx + dy * dy)
        if (L <= kep.BEFESTIGUNGSABSTAND_ABZUG) return null
        const spacingVal = computeBlueSpacing(L, kep)
        const unitX = dx / L
        const unitY = dy / L
        let circles = []
        const intervals = Math.floor((L - kep.BEFESTIGUNGSABSTAND_ABZUG) / spacingVal) + 1
        for (let i = 0; i <= intervals; i++) {
          const dist = kep.BEFESTIGUNGSABSTAND_ABZUG / 2 + i * spacingVal
          const cx = p.x + unitX * dist
          const cy = p.y + unitY * dist
          circles.push(
            <circle key={`bluepoint-${index}-${i}`} cx={cx} cy={cy} r={strokeWidth * 0.25} fill='blue' opacity={0.5} />
          )
        }
        return <g key={`bgroup-${index}`}>{circles}</g>
      })}
    </g>
  )

  const redPoints = (
    <g className='red-points'>
      {points.slice(0, points.length - 1).map((p, index) => {
        const next = points[index + 1]
        const dx = next.x - p.x
        const dy = next.y - p.y
        const L = Math.sqrt(dx * dx + dy * dy)
        if (L === 0) return null
        const unitX = dx / L
        const unitY = dy / L
        const redOffset = kep.BEFESTIGUNGSABSTAND_ABZUG / 2 + kep.ESP_VERSATZ
        const centerX = p.x + unitX * redOffset
        const centerY = p.y + unitY * redOffset
        const rectWidth = (strokeWidth * kep.STROKE_FAKTOR) / 2
        const rectHeight = (strokeWidth * kep.STROKE_FAKTOR) / 2
        const rectX = centerX - rectWidth / 2
        const rectY = centerY - rectHeight / 2
        return (
          <rect
            key={`red-point-${index}-${p.x}-${p.y}`}
            x={rectX}
            y={rectY}
            width={rectWidth}
            height={rectHeight}
            transform={`rotate(45, ${centerX}, ${centerY})`}
            fill='red'
            opacity={0.75}
          />
        )
      })}
    </g>
  )

  const greenStartPoint = (
    <circle cx={points[0].x - strokeWidth} cy={points[0].y - strokeWidth} r={strokeWidth * 0.4} fill='green' />
  )

  // Legenden
  const legendBaseX = minX + 1550 * maxScale
  const legendBaseY = maxY + legendMarginY
  const legendHorizontalSpacing = 750 * maxScale

  const blueLegend = (
    <g className='legend-blue' transform={`translate(${legendBaseX}, ${legendBaseY})`}>
      <circle cx='0' cy='0' r={strokeWidth * 0.35} fill='blue' opacity={0.5} />
      <text x={strokeWidth} y={strokeWidth * 0.085} fontSize={strokeWidth - 20} fill='black' alignmentBaseline='middle'>
        Befestigungspunkte
      </text>
    </g>
  )

  const redLegend = (
    <g className='legend-red' transform={`translate(${legendBaseX + legendHorizontalSpacing * 2}, ${legendBaseY})`}>
      <rect
        x={-((strokeWidth * kep.STROKE_FAKTOR) / 4)}
        y={-((strokeWidth * kep.STROKE_FAKTOR) / 4)}
        width={(strokeWidth * kep.STROKE_FAKTOR) / 2}
        height={(strokeWidth * kep.STROKE_FAKTOR) / 2}
        transform='rotate(45)'
        fill='red'
        opacity={0.8}
      />
      <text x={strokeWidth} y={strokeWidth * 0.085} fontSize={strokeWidth - 20} fill='black' alignmentBaseline='middle'>
        Einspeisungsmöglichkeit
      </text>
    </g>
  )

  const greenLegend = (
    <g className='legend-green' transform={`translate(${legendBaseX + legendHorizontalSpacing * 4.2}, ${legendBaseY})`}>
      <circle cx='0' cy='0' r={strokeWidth * 0.35} fill='green' />
      <text x={strokeWidth} y={strokeWidth * 0.085} fontSize={strokeWidth - 20} fill='black' alignmentBaseline='middle'>
        Startpunkt
      </text>
    </g>
  )

  const orangeLegend = (
    <g
      className='legend-orange'
      transform={`translate(${legendBaseX + legendHorizontalSpacing * 5.5}, ${legendBaseY})`}
    >
      <rect
        x={-((strokeWidth * kep.STROKE_FAKTOR) / 4)}
        y={-((strokeWidth * kep.STROKE_FAKTOR) / 2)}
        width={(strokeWidth * kep.STROKE_FAKTOR) / 2}
        height={(strokeWidth * kep.STROKE_FAKTOR) / 1.3}
        fill='orange'
      />
      <text x={strokeWidth} y={strokeWidth * 0.085} fontSize={strokeWidth - 20} fill='black' alignmentBaseline='middle'>
        Enddeckel
      </text>
    </g>
  )

  const generateDeckenausschnittArray = () => {
    const result = []
    if (kep.MONTAGEART_KEP !== 'EINBAU') return result
    const la = lengthA + kep.DECKENAUSSCHNITT_TOLERANZ
    const lb = lengthB + kep.DECKENAUSSCHNITT_TOLERANZ
    const lc = lengthC + kep.DECKENAUSSCHNITT_TOLERANZ
    const ld = lengthD + kep.DECKENAUSSCHNITT_TOLERANZ
    const width = kep.DECKENAUSSCHNITT_BREITE
    const depth = kep.EINBAUTIEFE_MIN
    result.push(`Deckenausschnitt A: L=${la} mm x B=${width} mm x ET=${depth} mm`)
    if (shape !== 'GERADE') {
      result.push(`Deckenausschnitt B: L=${lb} mm x B=${width} mm x ET=${depth} mm`)
    }
    if (['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape)) {
      result.push(`Deckenausschnitt C: L=${lc} mm x B=${width} mm x ET=${depth} mm`)
    }
    if (shape === 'RECHTECK') {
      result.push(`Deckenausschnitt D: L=${ld} mm x B=${width} mm x ET=${depth} mm`)
    }
    return result
  }

  const deckenausschnittRows = generateDeckenausschnittArray()

  // Hilfsfunktion: computeBlueSpacing (wie gehabt)
  function computeBlueSpacing(segLength, kep) {
    if (segLength <= kep.BEFESTIGUNGSABSTAND_ABZUG) return 0
    const effective = segLength - kep.BEFESTIGUNGSABSTAND_ABZUG
    const intervals = Math.ceil(effective / kep.BEFESTIGUNGSABSTAND_MAX)
    return Math.ceil(effective / intervals)
  }

  // Inline-Styles (aktualisiert mit Header-/Footer-Styles)
  const styleTag = (
    <style>{`
      html {
        margin: 50px;
      }
      body {
        font-family: Arial, sans-serif;
      }
      .configurator {
        max-width: 1020px;
        margin: auto;
        text-align: center;
      }
      label {
        display: block;
        margin-top: 10px;
        font-size: 18px;
        font-weight: bold;
      }
      .svg-container {
        width: 100%;
        height: auto;
        display: inline-block;
        border: 1px solid black;
        background-color: #f8f8f8;
        margin-top: 20px;
        overflow: visible;
      }
      .config-id {
        font-size: 22px;
        font-weight: bold;
        margin-top: 20px;
      }
      .facts-container,
      .facts-container2 {
        display: flex;
        flex-direction: column;
        margin-top: 10px;
        padding: 10px;
        font-size: 18px;
        max-width: 1920px;
        margin-left: 0;
        margin-bottom: 20px;
      }
      .facts-container ul,
      .facts-container2 ul {
        list-style-type: none;
        padding-left: 0;
      }
      .facts-container ul li,
      .facts-container2 ul li {
        border-bottom: 1px solid #000;
        padding-bottom: 5px;
        margin-bottom: 10px;
      }
      .facts-row,
      .facts-row2 {
        display: flex;
        justify-content: space-between;
        padding-bottom: 10px;
      }
      .facts-label {
        font-weight: bold;
        width: 30%;
        text-align: left;
      }
      .facts-value {
        width: 70%;
        text-align: right;
      }
      .facts-label2 {
        font-weight: bold;
        width: 0%;
        text-align: left;
      }
      .facts-value2 {
        width: 100%;
        text-align: left;
      }
      .facts-container h3,
      .facts-container2 h3 {
        text-align: left;
        margin-bottom: 10px;
        background-color: #f0f0f0;
        padding: 10px;
        border: 2px solid #ccc;
        border-radius: 1px;
      }
      @media print {
        button {
          display: none;
        }
      }
      .header {
        font-size: 18px;
        background-color: #f0f0f0;
        padding: 10px;
        text-align: center;
        border-bottom: 2px solid #ccc;
      }
      .footer {
        margin-top: 40px;
        font-size: 14px;
        color: #666;
        border-top: 1px solid #ccc;
        padding-top: 20px;
        text-align: center;
      }
      @media print {
        .header,
        .footer {
          position: fixed;
          width: 100%;
          left: 0;
        }
        .header {
          top: 0;
        }
        .footer {
          bottom: 0;
        }
      }
    `}</style>
  )

  return (
    <>
      {styleTag}
      {/* Neuer Header mit SVG-Logo */}
      {/* <div className='header'>
        <svg
          version='1.1'
          id='Ebene_1'
          xmlns='http://www.w3.org/2000/svg'
          xmlnsXlink='http://www.w3.org/1999/xlink'
          x='0px'
          y='0px'
          width='300px'
          height='auto'
          viewBox='0 0 200 28.3'
          style={{ enableBackground: 'new 0 0 200 28.3' }}
          xmlSpace='preserve'
        >
          <g transform='translate(-147 -38)'>
            <path d='M152.2,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H152.2 M152.2,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9 c0-3.1-1.5-4-6.5-4L152.2,53.7 M153.5,65.8H147V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8 c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C159.4,65.7,158.3,65.8,153.5,65.8' />
            <path d='M176.2,43v7.9h1.9c5.1,0,6.8-1,6.8-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L176.2,43 M191.6,65.8h-6.1L180,55.4 h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L191.6,65.8' />
            <path d='M205.5,66.3c-4.6,0-8.1-1.8-9.7-5.1c-0.9-1.7-1.1-3-1.1-7V38.5h5.3v15.7c0,3.3,0.1,4.3,0.9,5.5c1.1,1.5,2.8,2.3,4.6,2.1 c3.2,0,5.2-1.7,5.4-4.7c0.1-1,0.1-2,0.1-3V38.5h5.2v15.7c0,4-0.2,5.3-1.1,7C213.7,64.5,210,66.3,205.5,66.3' />
            <path d='M248.5,65.8h-4.7V44.5L238,65.8h-5.4l-5.7-21.3v21.3h-4.7V38.5h7.3l5.9,21.7l5.9-21.7h7.2V65.8z' />
            <path d='M259.9,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H259.9 M259.9,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9 c0-3.1-1.5-4-6.5-4L259.9,53.7 M261.2,65.8h-6.5V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8 c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C267.2,65.7,266,65.8,261.2,65.8' />
            <path d='M296.4,65.8h-17.6V38.5h17.1V43H284v6.4h10.8v4.4H284v7.4h12.4V65.8z' />
            <path d='M306.8,43v7.9h1.9c5.1,0,6.7-1,6.7-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L306.8,43 M322.2,65.8h-6.1l-5.6-10.4 h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L322.2,65.8' />
            <path d='M337,66.3c-7.7,0-12.6-5.4-12.6-14.1c0-8.6,4.8-14.3,12.2-14.3c6,0,9.7,3.5,10,9.3h-4.5c-0.5-3.2-2.2-4.8-5.4-4.8 c-4.3,0-6.8,3.6-6.8,9.7s2.6,9.6,7.1,9.6c2,0,4-0.7,5.7-1.8v-4.4h-5.5v-3.9h9.7v11.3C344.1,65.2,340.6,66.4,337,66.3' />
          </g>
        </svg>
      </div> */}

      <div className='configurator'>
        {/* <input
          type='text'
          value={configID}
          onChange={e => setConfigID(e.target.value)}
          placeholder='7436275-O-2985-1520-4185'
          style={{ width: '100%', padding: '10px', fontSize: '16px', textAlign: 'center' }}
        /> */}
        <h2>BRUMBERG BIRO40 LEUCHTENSYSTEM</h2>
        <div className='config-id'>Konfigurations-ID: {configID}</div>
        <img
          src={'/images/konfigurator/biro40/produktbilder/' + kep.HEADERBILD}
          alt='BIRO40'
          style={{ width: '100%', maxWidth: '100%', margin: '20px auto' }}
        />

        <div className='svg-container'>
          <svg width='100%' height='auto' viewBox={viewBox} preserveAspectRatio='xMidYMid meet'>
            <defs>{arrowMarker}</defs>
            <g>
              {orangeSquaresOnFigure}
              {polylineElement_0}
              {pinkSquare_0}
              {polylineElement}
              {pinkSquare}
              {arrowsElement}
              {grayLabels}
              {bluePoints}
              {redPoints}
              {greenStartPoint}
              {blueLegend}
              {redLegend}
              {greenLegend}
              {orangeLegend}
            </g>
          </svg>
        </div>

        <div className='facts-container'></div>
        <img
          src={'/images/konfigurator/biro40/figur/' + kep.SKIZZE}
          alt='BIRO40'
          style={{ width: '25%', maxWidth: '100%', margin: '20px auto' }}
        />
        <img
          src={'/images/konfigurator/biro40/produktbilder/' + kep.PRODUKTBILD}
          alt='BIRO40'
          style={{ width: '25%', height: '100%', maxWidth: '100%', margin: '20px auto' }}
        />
        <img
          src={'/images/konfigurator/biro40/polar/' + kep.POLARDIAGRAMM}
          alt='BIRO40'
          style={{ width: '25%', maxWidth: '100%', margin: '20px auto' }}
        />
        <img
          src={'/images/konfigurator/biro40/svg/' + kep.SVG_IMAGE}
          alt='BIRO40'
          style={{ width: '25%', maxWidth: '100%', margin: '20px auto' }}
        />

        {/* MECHANISCHE DATEN */}
        <div className='facts-container'>
          <h3>MECHANISCHE DATEN:</h3>
          <ul>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Material:</strong>
              </div>
              <div className='facts-value'>{kep.MATERIAL}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Farbe:</strong>
              </div>
              <div className='facts-value'>{kep.FARBE}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Profilquerschnitt:</strong>
              </div>
              <div className='facts-value'>{kep.PROFILQUERSCHNITT}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Nettogewicht pro Meter:</strong>
              </div>
              <div className='facts-value'>{kep.NETTOGEWICHT_M} kg/m</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Gesamtlänge:</strong>
              </div>
              <div className='facts-value'>{sumLengthM} m</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Gesamtgewicht:</strong>
              </div>
              <div className='facts-value'>{totalWeight} kg</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Montageart:</strong>
              </div>
              <div className='facts-value'>{kep.MONTAGEART}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Einbautiefe:</strong>
              </div>
              <div className='facts-value'>min. {kep.EINBAUTIEFE_MIN} mm</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Installationstyp:</strong>
              </div>
              <div className='facts-value'>{kep.INSTALLATIONSTYP}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Länge A:</strong>
              </div>
              <div className='facts-value'>{lengthA} mm</div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Länge B:</strong>
                </div>
                <div className='facts-value'>{lengthB} mm</div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Länge C:</strong>
                </div>
                <div className='facts-value'>{lengthC} mm</div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Länge D:</strong>
                </div>
                <div className='facts-value'>{lengthD} mm</div>
              </li>
            )}
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Gewicht A:</strong>
              </div>
              <div className='facts-value'>{weightA} kg</div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Gewicht B:</strong>
                </div>
                <div className='facts-value'>{weightB} kg</div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Gewicht C:</strong>
                </div>
                <div className='facts-value'>{weightC} kg</div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Gewicht D:</strong>
                </div>
                <div className='facts-value'>{weightD} kg</div>
              </li>
            )}
            {kep.MONTAGEART_KEP === 'EINBAU' &&
              deckenausschnittRows.map((line, idx) => {
                const [labelPart, valuePart] = line.split(':')
                return (
                  <li className='facts-row' key={idx}>
                    <div className='facts-label'>
                      <strong>{labelPart.trim()}:</strong>
                    </div>
                    <div className='facts-value'>{valuePart.trim()}</div>
                  </li>
                )
              })}
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Befestigungsabstand A:</strong>
              </div>
              <div className='facts-value'>{computeBlueSpacing(lengthA, kep)} mm</div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Befestigungsabstand B:</strong>
                </div>
                <div className='facts-value'>{computeBlueSpacing(lengthB, kep)} mm</div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Befestigungsabstand C:</strong>
                </div>
                <div className='facts-value'>{computeBlueSpacing(lengthC, kep)} mm</div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Befestigungsabstand D:</strong>
                </div>
                <div className='facts-value'>{computeBlueSpacing(lengthD, kep)} mm</div>
              </li>
            )}
          </ul>
        </div>

        {/* LICHTTECHNISCHE DATEN */}
        <div className='facts-container'>
          <h3>LICHTTECHNISCHE DATEN:</h3>
          <ul>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Nettolichtstrom pro Meter:</strong>
              </div>
              <div className='facts-value'>{kep.LUMEN_M_GESAMT} lm/m</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Farbtemperatur Direkt:</strong>
              </div>
              <div className='facts-value'>{kep.LICHTFARBE_DIREKT}</div>
            </li>
            {kep.LICHTRICHTUNG === 'DIREKT INDIREKT' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Farbtemperatur Indirekt:</strong>
                </div>
                <div className='facts-value'>{kep.LICHTFARBE_INDIREKT}</div>
              </li>
            )}
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Farbtemperatur einstellbar:</strong>
              </div>
              <div className='facts-value'>{kep.FARBTEMPERATUR_EINSTELLBAR}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lichtfarbe:</strong>
              </div>
              <div className='facts-value'>{kep.LICHTFARBE_FT}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Leuchtenoptik:</strong>
              </div>
              <div className='facts-value'>{kep.LEUCHTENOPTIK}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Reflektor:</strong>
              </div>
              <div className='facts-value'>{kep.REFLEKTOR}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Abstrahlwinkel:</strong>
              </div>
              <div className='facts-value'>{kep.ABSTRAHLWINKEL}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Blendungsbewertung:</strong>
              </div>
              <div className='facts-value'>{kep.BLENDUNGSBEWERTUNG}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lichtverteilung:</strong>
              </div>
              <div className='facts-value'>{kep.LICHTVERTEILUNG}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Farbtoleranz:</strong>
              </div>
              <div className='facts-value'>{kep.FARBTOLERANZ}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Farbwiedergabe:</strong>
              </div>
              <div className='facts-value'>{kep.FARBWIEDERGABE}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lichtstrom Gesamt:</strong>
              </div>
              <div className='facts-value'>{totalLightFlux} lm</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lichtstrom A:</strong>
              </div>
              <div className='facts-value'>{lightFluxA} lm</div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Lichtstrom B:</strong>
                </div>
                <div className='facts-value'>{lightFluxB} lm</div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Lichtstrom C:</strong>
                </div>
                <div className='facts-value'>{lightFluxC} lm</div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Lichtstrom D:</strong>
                </div>
                <div className='facts-value'>{lightFluxD} lm</div>
              </li>
            )}
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Effizienz:</strong>
              </div>
              <div className='facts-value'>{efficiency} lm/W</div>
            </li>
          </ul>
        </div>

        {/* ELEKTROTECHNISCHE DATEN */}
        <div className='facts-container'>
          <h3>ELEKTROTECHNISCHE DATEN:</h3>
          <ul>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Leistung pro Meter:</strong>
              </div>
              <div className='facts-value'>{kep.LEISTUNG_M_GESAMT} W/m</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Spannungsart:</strong>
              </div>
              <div className='facts-value'>{kep.SPANNUNGSART}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>AC-Nennspannung:</strong>
              </div>
              <div className='facts-value'>{kep.AC_NENNSPANNUNG}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Frequenz:</strong>
              </div>
              <div className='facts-value'>{kep.FREQUENZ}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Leuchtmittel:</strong>
              </div>
              <div className='facts-value'>{kep.LEUCHTMITTEL}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Schutzklasse:</strong>
              </div>
              <div className='facts-value'>{kep.SCHUTZKLASSE}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Schutzart (raumseitig):</strong>
              </div>
              <div className='facts-value'>{kep.SCHUTZART_RAUMSEITIG}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lebensdauer L70 B50 (25 °C):</strong>
              </div>
              <div className='facts-value'>{kep.LEBENSDAUER_L70B50_25}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lebensdauer L80 B50 (25 °C):</strong>
              </div>
              <div className='facts-value'>{kep.LEBENSDAUER_L80B50_25}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Dimmbarkeit:</strong>
              </div>
              <div className='facts-value'>{kep.DIMMBAR}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Dim-Ansteuerung:</strong>
              </div>
              <div className='facts-value'>{kep.DIM_ANSTEUERUNG}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Anzahl VG je Lichteinsatz:</strong>
              </div>
              <div className='facts-value'>{kep.ANZAHL_VG_LICHTEINSATZ}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Gesamtleistungsaufnahme:</strong>
              </div>
              <div className='facts-value'>{totalPower} W</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Leistung A:</strong>
              </div>
              <div className='facts-value'>{powerA} W</div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Leistung B:</strong>
                </div>
                <div className='facts-value'>{powerB} W</div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Leistung C:</strong>
                </div>
                <div className='facts-value'>{powerC} W</div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Leistung D:</strong>
                </div>
                <div className='facts-value'>{powerD} W</div>
              </li>
            )}
          </ul>
        </div>

        {/* KONFORMITÄT */}
        <div className='facts-container'>
          <h3>KONFORMITÄT:</h3>
          <ul>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Konformität:</strong>
              </div>
              <div className='facts-value'>{kep.KONFORMITAET}</div>
            </li>
          </ul>
        </div>

        {/* Ausschreibungstext */}
        <div className='facts-container2'>
          <h3>Ausschreibungstext:</h3>
          <ul>
            <li className='facts-row2'>
              <div className='facts-value2'>
                {(() => {
                  let text = `${kep.BASIS_TEXT} ${kep.ERWEITERTER_TEXT}`
                  text = text.replace('#lengthA#', lengthA)
                  text = text.replace('#lengthB#', lengthB)
                  text = text.replace('#lengthC#', lengthC)
                  text = text.replace('#lengthD#', lengthD)
                  return text
                })()}
              </div>
            </li>
          </ul>
        </div>

        {/* Kurztext */}
        <div className='facts-container2'>
          <h3>Kurztext:</h3>
          <ul>
            <li className='facts-row2'>
              <div className='facts-value2'>
                {kep.KURZBESCHREIBUNG} - {configID}
              </div>
            </li>
          </ul>
        </div>

        {/* Gesamt- & Schenkel-Details */}
        <div className='facts-container2'>
          <h3>GESAMT- & SCHENKEL-DETAILS</h3>
          <ul>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Lichtstrom (Gesamtoutput):</strong>
              </div>
              <div className='facts-value'>{totalLightFlux} lm</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Leistungsaufnahme (Gesamt):</strong>
              </div>
              <div className='facts-value'>{totalPower} W</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Anzahl Treiber (Gesamt):</strong>
              </div>
              <div className='facts-value'>{anzahlVGGtrA + anzahlVGGtrB + anzahlVGGtrC + anzahlVGGtrD}</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Gewicht (Gesamt):</strong>
              </div>
              <div className='facts-value'>{totalWeight} kg</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Profillänge (Gesamt):</strong>
              </div>
              <div className='facts-value'>{sumLengthM} m</div>
            </li>
            <li className='facts-row'>
              <div className='facts-label'>
                <strong>Info Schenkel A:</strong>
              </div>
              <div className='facts-value'>
                {lightFluxA} lm | {powerA} W | {anzahlVGGtrA} Treiber | {weightA} kg | {lengthA} mm
              </div>
            </li>
            {shape !== 'GERADE' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Info Schenkel B:</strong>
                </div>
                <div className='facts-value'>
                  {lightFluxB} lm | {powerB} W | {anzahlVGGtrB} Treiber | {weightB} kg | {lengthB} mm
                </div>
              </li>
            )}
            {['U-FORM', 'Z-FORM', 'RECHTECK'].includes(shape) && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Info Schenkel C:</strong>
                </div>
                <div className='facts-value'>
                  {lightFluxC} lm | {powerC} W | {anzahlVGGtrC} Treiber | {weightC} kg | {lengthC} mm
                </div>
              </li>
            )}
            {shape === 'RECHTECK' && (
              <li className='facts-row'>
                <div className='facts-label'>
                  <strong>Info Schenkel D:</strong>
                </div>
                <div className='facts-value'>
                  {lightFluxD} lm | {powerD} W | {anzahlVGGtrD} Treiber | {weightD} kg | {lengthD} mm
                </div>
              </li>
            )}
          </ul>
        </div>

        {/* Ausschreibungstext */}
        <div className='facts-container2'>
          <h3>Hinweise / Informationen:</h3>
          <p>
            Alle technischen Daten sowie Gewichts- und Maßangaben basieren auf Bemessungswerten und wurden sorgfältig
            erstellt.
          </p>
          <p>
            Technische Änderungen, die dem Fortschritt dienen, behalten wir uns jederzeit vor. Produktabbildungen sind
            beispielhaft und können vom Original abweichen.
          </p>
          <p>
            Stand 20.02.2025 Bestellung erfolgt zu unseren Allgemeinen Verkaufsbedingungen unter
            www.brumberg.com/de/agb/allgemeine-verkaufsbedingungen/.
          </p>
          <p>www.brumberg.com</p>
          <p>Irrtümer vorbehalten.</p>
          <p> </p>
        </div>

        {/* <div style={{ marginBottom: '20px' }}>
          <button onClick={() => window.print()}>Drucken (als PDF speichern)</button>
        </div> */}
      </div>

      {/* Neuer Footer */}
      {/* <div className='footer'>
        <p>
          Alle technischen Daten sowie Gewichts- und Maßangaben basieren auf Bemessungswerten und wurden sorgfältig
          erstellt.
        </p>
        <p>
          Technische Änderungen, die dem Fortschritt dienen, behalten wir uns jederzeit vor. Produktabbildungen sind
          beispielhaft und können vom Original abweichen.
        </p>
        <p>
          Stand 20.02.2025 Bestellung erfolgt zu unseren Allgemeinen Verkaufsbedingungen unter
          www.brumberg.com/de/agb/allgemeine-verkaufsbedingungen/.
        </p>
        <p>www.brumberg.com</p>
        <p>Irrtümer vorbehalten.</p>
        <p> </p>
      </div> */}
    </>
  )
}

// Skalierungsfunktion (wie gehabt)
function calculateScaledValue(value, reference, multiplier, decimals = 0) {
  const meters = value / reference
  return (multiplier * meters).toFixed(decimals)
}

export default LightConfigurator
