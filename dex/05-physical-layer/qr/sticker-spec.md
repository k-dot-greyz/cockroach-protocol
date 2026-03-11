# QR Sticker Specification

**Physical objective triggers using QR codes.**

---

## Purpose

QR stickers are **dead drops** placed in the real world that unlock objectives or verify capability.

**Core mechanic:**  
1. User scans QR code with phone  
2. Code contains objective ID or unlock token  
3. App records scan, updates node state, awards points  

---

## URL Structure

### Standard Format

```
https://cockroach.run/drop/{dropID}
```

**Example:**  
```
https://cockroach.run/drop/RIGA-BUREAU-001
```

### Query Parameters

**Optional verification:**

```
https://cockroach.run/drop/{dropID}?verify={token}
```

**Token** is a short hash to prevent spoofing (e.g., first 8 chars of HMAC).

**Example:**  
```
https://cockroach.run/drop/RIGA-BUREAU-001?verify=a3f7c2e1
```

---

## Drop ID Format

**Structure:** `{CITY}-{DOMAIN}-{NUMBER}`

**Examples:**  
- `RIGA-BUREAU-001` — Bureaucracy dead drop #1 in Riga  
- `RIGA-BUREAU-012` — Bureaucracy dead drop #12 in Riga  
- `RIGA-RUNWAY-003` — Runway dead drop #3 in Riga  
- `TALLINN-GEAR-007` — Gear dead drop #7 in Tallinn  

**City codes:**  
- `RIGA` — Riga, Latvia  
- `TALLINN` — Tallinn, Estonia  
- `VILNIUS` — Vilnius, Lithuania  
- `BERLIN` — Berlin, Germany  
- _(expand as needed)_  

**Domain codes:**  
- `BUREAU` — Bureaucracy  
- `RUNWAY` — Runway  
- `GEAR` — Gear  
- `INCOME` — Income  
- `DIGITAL` — Digital  
- `NETWORK` — Network  
- `SKILLS` — Skills  
- `RECOVERY` — Recovery  

---

## Sticker Design

### Visual Identity

**Aesthetic:** Encrypted cabal, tactical, minimal.

**Elements:**  
1. **QR code** (center, dominant)  
2. **Drop ID** (small text below QR, mono font)  
3. **Icon or emblem** (optional, domain-specific)  
4. **Warning text** (optional: "SCAN TO UNLOCK", "OBJECTIVE AVAILABLE")  

**Color schemes:**  
- **Dark theme:** Black background, white QR, cyan accent  
- **Light theme:** White background, black QR, teal accent  

**No:**  
- Bright colors  
- Playful fonts  
- Cartoon imagery  

---

### Sizes

**Standard sticker:** 50mm × 50mm (2" × 2")  
**Large sticker:** 75mm × 75mm (3" × 3")  
**Micro sticker:** 30mm × 30mm (1.2" × 1.2") (for covert placement)  

---

### Material

**Weatherproof vinyl stickers** (outdoor-rated, UV-resistant).  
**Indoor stickers** can be paper-based.  

**Adhesive:**  
- Permanent for long-term placements  
- Removable for temporary or private property placements  

---

## Placement Rules

### Legal and Ethical

1. **No vandalism** — Do not place stickers on private property without permission.  
2. **Public spaces only** — Bus stops, public notice boards, community spaces.  
3. **Respect removal** — If a sticker is removed, do not replace it without reassessing.  
4. **No sensitive locations** — Avoid schools, hospitals, religious sites unless explicitly permitted.  

### Strategic Placement

**Match domain to location:**

- **Bureaucracy** — Near embassies, consulates, government offices, social services centers  
- **Runway** — Near banks, co-working spaces, financial institutions  
- **Gear** — Near hardware stores, maker spaces, tech shops  
- **Network** — Near community centers, cafes, meetup venues  

**Visibility vs stealth:**

- **Easy drops** — Visible, accessible (coffee shop bulletin board)  
- **Medium drops** — Semi-hidden (inside a library, on a notice board)  
- **Hard drops** — Requires effort (inside an embassy, at the back of a government office)  

---

## Difficulty Tiers

### Easy (Public Access)

**Characteristics:**  
- No barriers to entry  
- Open during normal hours  
- No appointments needed  

**Examples:**  
- Coffee shop bulletin board  
- Public library notice board  
- Bus stop shelter  
- Community center  

**Points:** 5 pts per scan  

---

### Medium (Semi-Restricted)

**Characteristics:**  
- Requires some navigation  
- May need to enter a building  
- Might require business hours visit  

**Examples:**  
- Inside a bank branch  
- Government office lobby  
- Consulate entrance area (before security)  
- Co-working space common area  

**Points:** 10 pts per scan  

---

### Hard (Restricted Access)

**Characteristics:**  
- Appointment required  
- ID check at entrance  
- Social friction (need to ask clerk, wait in line)  
- May require specific documents  

**Examples:**  
- Inside an embassy (past security)  
- Government benefits office (after check-in)  
- Restricted library section (requires library card)  
- Private members' club  

**Points:** 20 pts per scan  

---

## Anti-Cheating Measures

### GPS Verification

**App checks GPS coordinates** at scan time.

**Tolerance:** 50–100 meters (accounts for GPS drift, indoor scans).

**If location mismatch:**  
- Scan rejected  
- Warning logged  
- Repeated attempts flag account for review  

### Time-Based Constraints

**Each drop can only be scanned once per user.**

**Cooldown period:** Some drops may have a cooldown (e.g., "Scan this drop once per quarter").

### Photo Proof (Optional)

**For Hard drops**, user may be required to upload a photo of the location as proof.

**Verification:**  
- Manual review by moderators  
- Community flagging for suspicious submissions  

---

## Drop Database Schema

**See:** `dex/02-data/schemas/dead-drop.schema.json`

**Key fields:**  
- `dropID` (unique identifier)  
- `domain` (which domain this drop belongs to)  
- `objective` (which objective this drop unlocks)  
- `difficulty` (easy, medium, hard)  
- `location` (GPS coordinates)  
- `address` (human-readable location)  
- `instructions` (how to find the sticker)  
- `verifyToken` (optional HMAC hash for anti-spoofing)  
- `active` (boolean, can be deactivated if sticker is removed)  

---

## Print Asset Requirements

**Files needed for each drop:**

1. **High-res PNG** (300 DPI, for print shops)  
2. **SVG** (vector, for scalability)  
3. **PDF** (print-ready with bleed and crop marks)  

**Naming convention:**  
```
{dropID}-{size}.{format}
```

**Example:**  
```
RIGA-BUREAU-001-50mm.png
RIGA-BUREAU-001-50mm.svg
RIGA-BUREAU-001-50mm.pdf
```

---

## Next Steps

1. Design sticker templates (dark + light themes)  
2. Generate QR codes for pilot drops (Riga Bureaucracy)  
3. Print first batch (10–20 stickers)  
4. Map placement locations  
5. Deploy pilot run  
6. Monitor scans and adjust  
