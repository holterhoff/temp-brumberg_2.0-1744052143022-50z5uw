import React, { useState, useEffect } from 'react'
import {
  Page,
  Document,
  StyleSheet,
  Text,
  View,
  Svg,
  Line,
  G,
  Path,
  Polyline,
  Circle,
  Image
} from '@react-pdf/renderer'

// -----------------------------------------------------
// 1) Deine KEP-Daten wie gehabt
// -----------------------------------------------------
const KEP = {
  lightingData: {
    colorTemperature: '4000K',
    lightFlux: '4000 lm',
    powerConsumption: '40W',
    luminousEfficiency: '100 lm/W',
    cri: 'Ra90',
    beamAngle: '120°',
    lifetime: '30,000 Stunden',
    lightDistribution: 'Symmetrisch',
    ipRating: 'IP44',
    color: 'Neutralweiß',
    energyClass: 'A++',
    dimmable: 'Ja',
    lightDirection: 'Direkt',
    opticalSystem: 'Asymmetrisch',
    totalLightFlux: '4500 lm'
  },
  electricalData: {
    voltage: '230V',
    current: '0.18A',
    powerFactor: '0.95',
    powerConsumption: '40W',
    ipRating: 'IP44',
    energyClass: 'A++',
    dimmable: 'Ja'
  },
  mechanicalData: {
    mountingType: 'Deckenmontage',
    housingColor: 'Weiß',
    ceilingCutout: '120mm',
    installationDepth: '100mm',
    crossSection: '3x1.5mm²'
  },
  basicData: {
    EULUM: 'DIREKT 3000 K RA>90 SATINIERT',
    PROFILQUERSCHNITT: '40 mm X 70 mm',
    BERECHNUNGSLAENGE: 1000,
    LUMEN_M_DIREKT: 1200,
    LUMEN_M_INDIREKT: 1200,
    LUMEN_M_GESAMT: 2400,
    LEISTUNG_M_DIREKT: 10,
    LEISTUNG_M_INDIREKT: 10,
    LEISTUNG_M_GESAMT: 20,
    GEWICHT_M: 3.4,
    DECKENAUSSCHNITT_LAENGE_ZUSATZ: 5,
    DECKENAUSSCHNITT_BREITE: 40,
    EINBAUTIEFE: 70
  }
}

// -----------------------------------------------------
// 2) PDF-Styles
// -----------------------------------------------------
const styles = StyleSheet.create({
  body: {
    fontSize: 9,
    paddingTop: 15,
    paddingBottom: 65,
    paddingHorizontal: 30
  },
  header: {
    marginBottom: 10
  },
  footer: {
    position: 'absolute',
    bottom: 20,
    left: 30,
    right: 30,
    fontSize: 7
  },
  pageNumber: {
    position: 'absolute',
    fontSize: 7,
    bottom: 10,
    left: 0,
    right: 0,
    textAlign: 'center',
    color: 'grey'
  },
  line: {
    marginVertical: 5
  },
  sectionTitle: {
    fontSize: 10,
    fontWeight: 'bold',
    marginTop: 10,
    marginBottom: 5
  },
  factsContainer: {
    marginBottom: 10,
    paddingBottom: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc'
  },
  factsRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 4
  },
  factsLabel: {
    fontWeight: 'bold',
    width: '50%'
  },
  factsValue: {
    width: '50%',
    textAlign: 'right'
  },
  greeting: {
    marginTop: 30,
    fontSize: 8
  },
  // Ein Container pro Daten-Block (z. B. MECHANISCHE DATEN)
  factsContainer: {
    marginBottom: 10
    // optional: borderBottomWidth: 1, borderBottomColor: '#ccc'
  },
  factsTitle: {
    fontSize: 10,
    fontWeight: 'bold',
    marginBottom: 5
  },

  // TABLE-Stile:
  table: {
    display: 'table',
    width: 'auto',
    borderStyle: 'solid',
    borderWidth: 0.5,
    borderColor: '#ccc',
    marginBottom: 5
  },
  tableRow: {
    // Jede Zeile = row
    margin: 'auto',
    flexDirection: 'row'
  },
  tableCol: {
    // Zwei Spalten = 50% each
    width: '50%',
    borderStyle: 'solid',
    borderWidth: 0.5,
    borderColor: '#ccc',
    padding: 4
  },
  tableCell: {
    fontSize: 9
    // z.B. textAlign: 'left'
  },
  tableHeaderCell: {
    fontSize: 9,
    fontWeight: 'bold'
  }
})

// -----------------------------------------------------
// 3) Logo, Header und Footer
// -----------------------------------------------------
const Logo = () => (
  <View style={styles.logo}>
    <Svg width='400' height='80' viewBox='0 0 0 200'>
      <G fill='black'>
        <Path d='M 468.31 89.23 C 475.38 88.73 483.16 88.46 489.25 92.76 C 495.78 96.92 498.67 104.73 499.22 112.16 C 495.49 112.25 491.75 112.24 488.02 112.20 C 486.78 108.22 485.36 103.69 481.34 101.67 C 475.20 98.68 466.83 99.97 462.54 105.53 C 457.84 111.58 457.09 119.65 457.40 127.05 C 457.71 134.29 460.05 142.43 466.70 146.32 C 473.83 150.38 482.58 147.99 489.17 143.96 C 489.22 140.28 489.22 136.60 489.16 132.93 C 484.56 132.88 479.96 132.89 475.36 132.83 C 475.37 129.60 475.37 126.36 475.37 123.13 C 483.47 122.72 491.59 122.96 499.71 122.92 C 499.94 130.62 499.73 138.32 499.85 146.02 C 499.78 147.94 500.02 149.95 499.43 151.82 C 492.69 157.47 483.75 160.33 474.98 159.98 C 467.50 160.17 459.82 157.88 454.21 152.81 C 447.45 146.85 444.22 137.82 443.58 129.01 C 442.90 119.58 444.26 109.60 449.50 101.54 C 453.62 95.01 460.63 90.28 468.31 89.23 Z' />
        <Path d='M 0.00 90.23 C 8.01 90.25 16.02 90.08 24.02 90.29 C 29.74 90.52 36.03 91.46 40.19 95.80 C 45.14 100.54 46.00 108.40 43.53 114.58 C 41.98 118.28 38.24 120.19 34.97 122.11 C 38.53 123.60 42.38 124.99 44.95 128.02 C 51.21 135.79 49.27 148.45 41.36 154.38 C 36.81 158.08 30.70 158.56 25.07 158.74 C 16.72 158.88 8.36 158.75 0.00 158.78 L 0.00 90.23 M 13.12 101.23 C 13.10 106.72 13.10 112.22 13.13 117.72 C 17.94 117.62 22.96 118.24 27.57 116.53 C 33.66 114.42 33.57 103.53 27.06 102.03 C 22.52 100.81 17.77 101.29 13.12 101.23 M 13.08 128.49 C 13.15 135.03 13.08 141.57 13.14 148.12 C 19.42 148.04 26.22 148.92 32.03 146.07 C 37.23 142.11 36.37 131.32 29.48 129.56 C 24.15 128.09 18.55 128.45 13.08 128.49 Z' />
        <Path d='M 59.89 90.24 C 67.27 90.20 74.66 90.17 82.05 90.24 C 88.06 90.40 94.55 90.70 99.64 94.31 C 109.65 101.08 111.13 117.14 102.76 125.76 C 100.88 127.71 98.54 129.13 96.28 130.59 C 101.18 140.06 106.69 149.21 111.45 158.75 C 106.37 158.84 101.30 158.80 96.22 158.76 C 92.04 151.24 88.18 143.55 84.16 135.94 C 83.47 134.87 83.04 133.51 81.88 132.86 C 78.97 132.56 76.05 132.75 73.14 132.79 C 73.08 141.44 73.23 150.10 73.06 158.76 C 68.67 158.82 64.28 158.82 59.89 158.76 C 59.77 135.92 59.78 113.08 59.89 90.24 M 73.09 101.71 C 73.16 108.25 73.13 114.79 73.11 121.33 C 78.88 121.31 84.96 121.76 90.37 119.41 C 96.61 116.37 95.92 106.04 89.81 103.19 C 84.59 100.79 78.65 101.81 73.09 101.71 Z' />
        <Path d='M 119.19 90.25 C 123.64 90.18 128.09 90.17 132.55 90.27 C 132.62 105.86 132.23 121.46 132.78 137.04 C 132.85 142.80 137.60 147.85 143.24 148.57 C 148.15 149.06 153.87 148.24 157.11 144.12 C 159.65 141.04 159.78 136.86 159.86 133.06 C 159.99 118.79 159.73 104.52 159.99 90.25 C 164.32 90.18 168.65 90.18 172.98 90.25 C 173.23 104.83 173.07 119.42 173.07 134.01 C 173.18 141.39 171.01 149.30 165.14 154.18 C 158.50 159.76 149.27 160.56 140.96 159.71 C 133.32 158.92 125.69 154.79 122.14 147.76 C 119.57 143.31 119.23 138.07 119.22 133.05 C 119.17 118.78 119.23 104.51 119.19 90.25 Z' />
        <Path d='M 187.92 90.24 C 194.07 90.21 200.24 90.10 206.39 90.34 C 211.19 108.23 216.08 126.09 220.87 143.98 C 221.44 142.50 221.94 141.00 222.37 139.48 C 226.68 123.07 231.27 106.74 235.58 90.33 C 241.63 90.11 247.69 90.19 253.75 90.25 C 253.71 113.08 253.71 135.92 253.75 158.75 C 249.81 158.81 245.87 158.81 241.93 158.77 C 241.68 141.67 242.11 124.55 241.74 107.46 C 236.57 124.40 232.41 141.65 227.61 158.70 C 223.08 158.84 218.55 158.81 214.02 158.78 C 209.65 143.40 205.77 127.89 201.56 112.46 C 201.14 111.03 200.61 109.62 200.07 108.23 C 199.58 125.06 199.98 141.92 199.87 158.76 C 195.88 158.81 191.90 158.81 187.91 158.77 C 187.81 135.92 187.81 113.08 187.92 90.24 Z' />
        <Path d='M 269.24 90.24 C 276.85 90.20 284.46 90.16 292.07 90.25 C 297.90 90.40 304.30 91.08 308.81 95.18 C 314.41 100.09 315.67 108.83 312.40 115.38 C 310.68 118.65 307.23 120.32 304.19 122.10 C 307.74 123.51 311.53 124.89 314.08 127.90 C 317.68 131.90 318.27 137.67 317.57 142.80 C 316.27 151.10 308.78 157.77 300.43 158.31 C 290.06 159.23 279.63 158.64 269.24 158.75 C 269.26 135.92 269.26 113.08 269.24 90.24 M 282.28 101.24 C 282.27 106.73 282.27 112.22 282.28 117.71 C 287.06 117.63 292.03 118.20 296.64 116.63 C 302.02 114.90 302.83 106.60 298.77 103.21 C 293.81 100.29 287.75 101.45 282.28 101.24 M 282.29 128.41 C 282.27 134.97 282.26 141.53 282.29 148.08 C 288.13 148.18 294.16 148.61 299.79 146.78 C 302.70 145.92 304.33 142.94 304.39 140.04 C 304.80 136.31 303.96 131.53 300.00 130.04 C 294.37 127.90 288.19 128.57 282.29 128.41 Z' />
        <Path d='M 329.38 90.26 C 343.67 90.16 357.96 90.22 372.26 90.23 C 372.35 94.03 372.35 97.84 372.20 101.64 C 362.34 101.68 352.49 101.56 342.63 101.69 C 342.58 107.00 342.44 112.31 342.79 117.61 C 351.75 117.63 360.71 117.34 369.66 117.75 C 369.60 121.39 369.61 125.03 369.62 128.68 C 360.63 128.80 351.63 128.62 342.63 128.76 C 342.57 134.87 342.54 140.99 342.65 147.10 C 352.98 147.21 363.31 147.05 373.64 147.17 C 373.64 151.03 373.64 154.89 373.65 158.75 C 358.89 158.82 344.13 158.83 329.38 158.74 C 329.42 135.91 329.42 113.09 329.38 90.26 Z' />
        <Path d='M 386.15 90.24 C 393.79 90.21 401.43 90.16 409.07 90.25 C 415.02 90.43 421.46 90.89 426.37 94.64 C 435.04 100.96 436.96 114.32 431.12 123.15 C 429.00 126.43 425.68 128.59 422.55 130.79 C 427.75 140.09 432.95 149.40 438.10 158.73 C 432.91 158.83 427.72 158.87 422.54 158.66 C 417.98 150.04 413.35 141.45 408.75 132.84 C 405.60 132.72 402.46 132.73 399.31 132.82 C 399.28 141.47 399.40 150.12 399.26 158.77 C 394.89 158.81 390.52 158.82 386.15 158.76 C 386.18 135.92 386.18 113.08 386.15 90.24 M 399.64 101.69 C 399.59 108.25 399.57 114.80 399.65 121.36 C 405.29 121.30 411.22 121.73 416.54 119.51 C 422.94 116.54 422.15 105.86 415.90 103.09 C 410.79 100.87 405.04 101.80 399.64 101.69 Z' />
      </G>
    </Svg>
  </View>
)

const Header = () => (
  <View style={styles.header}>
    <Logo></Logo>
    {/* <Text style={styles.logotext}>BRUMBERG</Text> */}
    <View style={styles.anschrift}>
      <Text style={styles.anschriftText}>BRUMBERG GmbH & Co.KG | Hellefelder Str. 63 | 59846 Sundern</Text>
    </View>
  </View>
)

const Footer = () => (
  <View style={styles.footer}>
    <Text>BRUMBERG Leuchten GmbH & Co. KG | Fon: +49 (0) 29 34 / 96 11-0 | info@brumberg.de</Text>
    <Text>www.brumberg.com | Amtsgericht Arnsberg - HRA 2614</Text>
    <Text style={styles.pageNumber} render={({ pageNumber, totalPages }) => `${pageNumber} / ${totalPages}`} fixed />
  </View>
)

// -----------------------------------------------------
// 4) Hilfskonstanten und Methoden für die Shape-Logik
// -----------------------------------------------------
const shapeMap = { I: 'GERADE', L: 'L-FORM', U: 'U-FORM', Z: 'Z-FORM', O: 'RECHTECK' }

// -----------------------------------------------------
// 5) Haupt-Komponente, die das PDF erzeugt
// -----------------------------------------------------
const DatenblattBiro40 = props => {
  // Statische Beispiel-ID. Du kannst sie als Prop übergeben oder im State ändern.
  const [configID] = useState(props.id)
  const [kep, setKep] = useState({})
  const [shape, setShape] = useState('RECHTECK')
  const [lengthA, setLengthA] = useState(0)
  const [lengthB, setLengthB] = useState(0)
  const [lengthC, setLengthC] = useState(0)
  const [lengthD, setLengthD] = useState(0)

  // parse Konfig-ID
  const parseConfigurationID = id => {
    const parts = id.split('-')
    if (parts.length < 3) return
    const newShape = shapeMap[parts[1]] || 'RECHTECK'
    setShape(newShape)
    setLengthA(parseInt(parts[2]) || 0)
    setLengthB(parts[3] ? parseInt(parts[3]) : 0)
    setLengthC(parts[4] ? parseInt(parts[4]) : 0)
    setLengthD(parts[5] ? parseInt(parts[5]) : 0)
  }

  useEffect(() => {
    parseConfigurationID(configID)

    // Hole KEP DATEN zur ID
    console.log(configID)
    const parts = configID.split('-')
    const [kepID, figur] = parts

    const fetchDetailsForIds = async () => {
      try {
        const response = await fetch(`/api/biro40/getKepDataSheet?id=${kepID}&figur=${figur}`)
        const result = await response.json()
        if (result && result.length > 0) {
          setKep(result[0])
        }
      } catch (error) {
        console.error(`Error fetching details for ID ${item.ID}:`, error)
      }
    }

    fetchDetailsForIds()
  }, [configID])

  // Gesamtlänge, Gewicht, Lichtstrom
  const getSumLength = () => {
    if (shape === 'GERADE') return lengthA
    if (shape === 'L-FORM') return lengthA + lengthB
    if (shape === 'U-FORM' || shape === 'Z-FORM') return lengthA + lengthB + lengthC
    if (shape === 'RECHTECK') return lengthA + lengthB + lengthC + lengthD
    return 0
  }
  const calculateTotalWeight = () => {
    const sum = getSumLength()
    const meters = sum / KEP.basicData.BERECHNUNGSLAENGE
    return (meters * KEP.basicData.GEWICHT_M).toFixed(2)
  }
  const calculateTotalLightFlux = () => {
    const sum = getSumLength()
    const meters = sum / KEP.basicData.BERECHNUNGSLAENGE
    return (KEP.basicData.LUMEN_M_GESAMT * meters).toFixed(0)
  }
  const generateLabelText = () => {
    let text = [`A = ${lengthA} mm`]
    if (shape !== 'GERADE') text.push(`B = ${lengthB} mm`)
    if (shape === 'U-FORM' || shape === 'Z-FORM' || shape === 'RECHTECK') text.push(`C = ${lengthC} mm`)
    if (shape === 'RECHTECK') text.push(`D = ${lengthD} mm`)
    return text.join(' | ')
  }

  // -----------------------------------------------------
  // 6) Die komplette Shape-SVG-Logik aus dem Konfigurator
  // -----------------------------------------------------
  const startX = 50
  const startY = 50
  // Für die PDF-Ansicht: Du kannst maxLength auch kleiner/größer wählen.
  const maxLength = Math.max(lengthA, lengthB, lengthC, lengthD, 1000) / 5000
  const strokeWidth = 150 * maxLength
  const offset = 300 * maxLength

  // Punkte berechnen
  const calculatePoints = () => {
    let points = [{ x: startX, y: startY }]
    if (shape === 'GERADE') {
      points.push({ x: startX + lengthA, y: startY })
    } else if (shape === 'L-FORM') {
      points.push({ x: startX + lengthA, y: startY })
      points.push({ x: startX + lengthA, y: startY + lengthB })
    } else if (shape === 'U-FORM' || shape === 'Z-FORM') {
      points.push({ x: startX + lengthA, y: startY })
      points.push({ x: startX + lengthA, y: startY + lengthB })
      const lastX = shape === 'Z-FORM' ? startX + lengthA + lengthC : startX + lengthA - lengthC
      const lastY = startY + lengthB
      points.push({ x: lastX, y: lastY })
    } else if (shape === 'RECHTECK') {
      points.push({ x: startX + lengthA, y: startY })
      points.push({ x: startX + lengthA, y: startY + lengthB })
      points.push({ x: startX, y: startY + lengthB })
      // Hier ein kleiner „Hack“, damit man ein geschlossenes Rechteck
      // als Polylinie sieht. Du kannst es nach Belieben anpassen.
      points.push({ x: startX, y: startY - strokeWidth / 2 })
    }
    return points
  }

  const points = calculatePoints()
  const polylinePoints = points.map(p => `${p.x},${p.y}`).join(' ')

  // Min/Max für viewBox
  const minX = Math.min(...points.map(p => p.x)) - offset
  const minY = Math.min(...points.map(p => p.y)) - offset
  const maxX = Math.max(...points.map(p => p.x)) + offset
  const maxY = Math.max(...points.map(p => p.y)) + offset
  const widthBox = maxX - minX
  const heightBox = maxY - minY
  const viewBox = `${minX} ${minY} ${widthBox} ${heightBox}`

  // Kreise + Labels A/B/C/D
  const segmentLabels = ['A', 'B', 'C', 'D']
  const circles = points.map((p, index) => {
    if (index < points.length - 1) {
      const next = points[index + 1]
      const centerX = (p.x + next.x) / 2
      const centerY = (p.y + next.y) / 2
      return (
        <G key={`circle-${index}`}>
          <Circle
            cx={centerX}
            cy={centerY}
            r={strokeWidth * 1.25}
            fill='gray'
            fillOpacity='0.8'
            stroke='black'
            strokeWidth='2'
          />
          <Text
            x={centerX}
            y={centerY + strokeWidth * 0.4}
            fontSize={10 + strokeWidth}
            fill='white'
            stroke='black'
            strokeWidth={strokeWidth * 0.005}
            textAnchor='middle'
          >
            {segmentLabels[index]}
          </Text>
        </G>
      )
    }
    return null
  })

  // -----------------------------------------------------
  // 7) PDF-Struktur (Page) mit allen Daten
  // -----------------------------------------------------
  return (
    <Document>
      <Page size='A4' style={styles.body}>
        {/* <Header /> */}
        <Image src={`/images/konfigurator/biro40/${kep.headerbild}`} style={{ width: '100%', height: '15%' }} />
        {/* <Image src={`/images/konfigurator/biro40/biro40_header.jpg`} style={{ width: '100%', height: '15%' }} /> */}

        <Text style={{ fontSize: 12, marginBottom: 5 }}>BRUMBERG BIRO40 LEUCHTENSYSTEM</Text>
        <Text style={{ fontSize: 10, marginBottom: 10 }}>Konfigurations-ID: {configID}</Text>

        {/* Das SVG zeigt die Form (Polyline) + Kreise/Labels */}
        <View style={{ marginBottom: 10 }}>
          <Svg width='80%' height='80%' viewBox={viewBox} preserveAspectRatio='xMidYMid meet'>
            <Polyline points={polylinePoints} fill='none' stroke='black' strokeWidth={strokeWidth} />
            {circles}
          </Svg>
        </View>
      </Page>
      <Page size='A4' style={styles.body}>
        {/* ---------- MECHANISCHE DATEN ---------- */}
        <View style={styles.factsContainer}>
          <Text style={styles.factsTitle}>MECHANISCHE DATEN:</Text>

          <View style={styles.table}>
            {/* Optional: Tabellen-Kopfzeile */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Merkmal</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Wert</Text>
              </View>
            </View>

            {/* Form */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Form:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{shape}</Text>
              </View>
            </View>

            {/* Schenkel A */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Schenkel A:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{lengthA} mm</Text>
              </View>
            </View>

            {/* Schenkel B, nur wenn shape !== "GERADE" */}
            {shape !== 'GERADE' && (
              <View style={styles.tableRow}>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>Schenkel B:</Text>
                </View>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>{lengthB} mm</Text>
                </View>
              </View>
            )}

            {/* Schenkel C, nur bei U-FORM / Z-FORM / RECHTECK */}
            {(shape === 'U-FORM' || shape === 'Z-FORM' || shape === 'RECHTECK') && (
              <View style={styles.tableRow}>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>Schenkel C:</Text>
                </View>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>{lengthC} mm</Text>
                </View>
              </View>
            )}

            {/* Schenkel D, nur bei RECHTECK */}
            {shape === 'RECHTECK' && (
              <View style={styles.tableRow}>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>Schenkel D:</Text>
                </View>
                <View style={styles.tableCol}>
                  <Text style={styles.tableCell}>{lengthD} mm</Text>
                </View>
              </View>
            )}

            {/* Gesamtlänge */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Gesamtlänge:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{generateLabelText()}</Text>
              </View>
            </View>

            {/* Gesamtgewicht */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Gesamtgewicht:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{calculateTotalWeight()} kg</Text>
              </View>
            </View>

            {/* Montageart */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Montageart:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.mechanicalData.mountingType}</Text>
              </View>
            </View>

            {/* Gehäusefarbe */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Gehäusefarbe:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.mechanicalData.housingColor}</Text>
              </View>
            </View>

            {/* Deckenausschnitt */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Deckenausschnitt:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.mechanicalData.ceilingCutout}</Text>
              </View>
            </View>

            {/* Einbautiefe */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Einbautiefe:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.mechanicalData.installationDepth}</Text>
              </View>
            </View>

            {/* Querschnitt */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Querschnitt:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.mechanicalData.crossSection}</Text>
              </View>
            </View>
          </View>
        </View>

        {/* ---------- LICHTTECHNISCHE DATEN ---------- */}
        <View style={styles.factsContainer}>
          <Text style={styles.factsTitle}>LICHTTECHNISCHE DATEN:</Text>

          <View style={styles.table}>
            {/* Kopf optional */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Merkmal</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Wert</Text>
              </View>
            </View>

            {/* Farbtemperatur */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Farbtemperatur:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.lightingData.colorTemperature}</Text>
              </View>
            </View>

            {/* Lichtstrom */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Lichtstrom:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.lightingData.lightFlux}</Text>
              </View>
            </View>

            {/* usw... alle weiteren Felder genauso */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Gesamtlichtstrom:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{calculateTotalLightFlux()} lm</Text>
              </View>
            </View>
          </View>
        </View>

        {/* ---------- ELEKTROTECHNISCHE DATEN ---------- */}
        <View style={styles.factsContainer}>
          <Text style={styles.factsTitle}>ELEKTROTECHNISCHE DATEN:</Text>

          <View style={styles.table}>
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Merkmal</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Wert</Text>
              </View>
            </View>

            {/* Spannung */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Spannung:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{KEP.electricalData.voltage}</Text>
              </View>
            </View>

            {/* ...weitere Felder... */}
          </View>
        </View>

        {/* ---------- EAN UND PREIS ---------- */}
        <View style={styles.factsContainer}>
          <Text style={styles.factsTitle}>EAN UND PREIS:</Text>

          <View style={styles.table}>
            {/* Kopf optional */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Merkmal</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableCell, styles.tableHeaderCell]}>Wert</Text>
              </View>
            </View>

            {/* EAN */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>EAN:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>1234567890123</Text>
              </View>
            </View>

            {/* Preis */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Preis:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>49.99 EUR</Text>
              </View>
            </View>

            {/* Konfig-ID */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Konfigurations-ID:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{configID}</Text>
              </View>
            </View>

            {/* Konfig-ID */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>Entsorgung am Ende der Lebensdauer:</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>
                  Das Produkt darf nicht mit dem Hausmüll entsorgt werden. Sie sind verpflichtet, solche
                  Elektro-Altgeräte separat zu entsorgen. Informieren Sie sich bitte bei Ihrer Kommune über die
                  Möglichkeiten der geregelten Entsorgung. Mit der getrennten Entsorgung führen Sie die Altgeräte dem
                  Recycling oder anderen Formen der Wiederverwertung zu. Sie helfen damit zu vermeiden, dass u. U.
                  belastende Stoffe in die Umwelt gelangen.
                </Text>
              </View>
            </View>
          </View>
        </View>

        {/* ---------- Gruß + Footer ---------- */}
        <View style={styles.greeting}>
          <Text>Mit freundlichen Grüßen</Text>
          <Text>BRUMBERG GmbH & Co.KG</Text>
        </View>
        <Footer />
      </Page>
    </Document>
  )
}

export default DatenblattBiro40
