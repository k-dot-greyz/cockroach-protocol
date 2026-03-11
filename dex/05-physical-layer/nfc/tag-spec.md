# NFC Tag Specification

**Physical capability verification using NFC tags.**

---

## Purpose

NFC tags are **proof-of-capability** triggers attached to physical objects or locations.

**Core mechanic:**  
1. User taps phone to NFC tag  
2. Tag contains objective ID or unlock token  
3. App records tap, verifies proof, updates node state  

---

## NFC vs QR

**Use NFC when:**  
- Capability involves owning or accessing a specific physical object  
- Higher security is needed (NFC harder to spoof than QR screenshot)  
- Placement needs to be covert (NFC tags are small, can be hidden)  

**Use QR when:**  
- Objective is location-based (dead drop at embassy)  
- User might not have NFC-enabled phone  
- Sticker needs to be visible for discovery  

---

## Tag Types

### NTAG215 (Recommended)

**Specs:**  
- 504 bytes usable memory  
- ISO 14443A standard  
- Read/write  
- Compatible with all modern smartphones  

**Use for:** Gear nodes, Bureaucracy nodes, objective unlocks  

### NTAG213

**Specs:**  
- 144 bytes usable memory  
- ISO 14443A standard  
- Cheaper than NTAG215  

**Use for:** Simple URL redirects, low-data objectives  

### Mifare Classic (Avoid)

**Why avoid:**  
- Security vulnerabilities  
- Limited smartphone compatibility  
- Deprecated in many systems  

---

## Data Structure

### NDEF Record Format

**NFC Data Exchange Format (NDEF)** is the standard for NFC data.

**Structure:**  
1. **Record type:** URL  
2. **Payload:** `https://cockroach.run/tap/{tagID}?verify={token}`  

**Example:**  
```
https://cockroach.run/tap/RIGA-GEAR-BACKUP-PHONE?verify=b4e8d1f3
```

---

## Tag ID Format

**Structure:** `{CITY}-{DOMAIN}-{NODE}-{OBJECT}`

**Examples:**  
- `RIGA-GEAR-BACKUP-PHONE` — Backup phone (Gear node)  
- `RIGA-BUREAU-PASSPORT` — Passport (Bureaucracy node)  
- `RIGA-DIGITAL-BACKUP-DRIVE` — Backup drive (Digital node)  

---

## Node Mapping

**NFC tags map directly to nodes.**

**Example: Backup Phone Node**

**Node:** "Backup phone with active SIM" (Gear domain)  
**NFC tag:** Attached to the backup phone itself  
**Objective:** "Tap NFC tag on backup phone to verify"  
**Proof:** Tag tap confirms user owns and can access the device  

**State transition:**  
- Before tap: Node is **Active**  
- After tap: Node is **Secured**  

---

## Placement Strategies

### Gear Nodes

**Attach tags to:**  
- Backup phone  
- Backup laptop  
- External hard drive  
- Power bank  
- Emergency cash stash container  
- Fireproof document safe  

**Why:**  
Proof that the user actually owns and can physically access the gear.

---

### Bureaucracy Nodes

**Attach tags to:**  
- Passport (inside cover or on protective sleeve)  
- National ID card holder  
- Document vault folder  
- Benefits card holder  

**Why:**  
Proof that the user has the document and it's accessible.

---

### Digital Nodes

**Attach tags to:**  
- Backup drive  
- USB key with encrypted vault  
- Faraday bag (if using one for device security)  

**Why:**  
Proof that digital backups exist physically.

---

## Security Considerations

### Anti-Spoofing

**Problem:** User could write the same NFC tag to multiple devices and "verify" gear they don't actually have.

**Solution:**  
1. **Unique tag IDs** — Each tag has a unique serial number (UID).  
2. **Server-side verification** — App sends UID to server, server checks if it matches registered tag.  
3. **One-time registration** — First tap registers the tag to the user's account. Subsequent taps must match the same UID.  

### Privacy

**Problem:** If tag contains full URL with user data, anyone can scan it.

**Solution:**  
1. **Generic URLs** — Tag contains generic redirect, not user-specific data.  
2. **App-side auth** — After tap, app checks if user is logged in before crediting.  
3. **Verify token** — Short hash in URL prevents direct spoofing but doesn't reveal user identity.  

---

## Encoding Process

### Tools

**NFC Tools (Android/iOS)** — Free app for writing NDEF records to tags.  
**TagWriter by NXP (Android/iOS)** — Official app from NXP Semiconductors.  

### Steps

1. **Generate tag ID** (e.g., `RIGA-GEAR-BACKUP-PHONE`)  
2. **Generate verify token** (HMAC of tag ID + secret key, first 8 chars)  
3. **Construct URL** (`https://cockroach.run/tap/{tagID}?verify={token}`)  
4. **Write NDEF record** to tag using NFC Tools app  
5. **Test tap** with target device  
6. **Register tag** in database with UID  

---

## Tag Database Schema

**See:** `dex/02-data/schemas/dead-drop.schema.json` (shared with QR drops)

**Key fields:**  
- `tagID` (unique identifier)  
- `tagUID` (NFC tag's unique serial number)  
- `domain` (which domain this tag belongs to)  
- `node` (which node this tag verifies)  
- `verifyToken` (HMAC hash for anti-spoofing)  
- `registeredUser` (user ID who registered this tag, null if unregistered)  
- `active` (boolean, can be deactivated if tag is lost)  

---

## User Flow Example

### Scenario: User wants to secure "Backup Phone" node

1. **User purchases NFC tag** (NTAG215, 10-pack on Amazon)  
2. **User encodes tag** with URL: `https://cockroach.run/tap/BACKUP-PHONE?verify=a3f7c2e1`  
3. **User attaches tag** to backup phone case  
4. **User opens Cockroach app** → navigates to Gear domain → "Backup Phone" node  
5. **User taps "Verify with NFC"** button  
6. **User taps phone to NFC tag** on backup device  
7. **App reads tag**, sends UID + verify token to server  
8. **Server validates**, credits user, updates node state: **Active → Secured**  
9. **Achievement unlocked:** "Gear Secured" badge  
10. **Domain Ascent:** +10 pts in Gear domain  

---

## Tag Procurement

**Recommended suppliers:**  

- **Amazon** — NTAG215 bulk packs (10–50 tags)  
- **AliExpress** — Cheaper, longer shipping  
- **Local electronics stores** — May carry NFC tags  

**Price range:**  
- NTAG215: $0.50–$1.00 per tag (bulk)  
- NTAG213: $0.30–$0.60 per tag (bulk)  

**Form factors:**  
- Stickers (adhesive back)  
- Cards (credit-card size)  
- Key fobs  
- Discs (coin-sized)  

**For Cockroach Protocol:** Stickers are most versatile (can attach to any object).

---

## Next Steps

1. Purchase NTAG215 tags (pilot batch: 20 tags)  
2. Define tag ID naming conventions  
3. Build NFC tap handler in app  
4. Implement server-side UID verification  
5. Create tag encoding guide for users  
6. Test with pilot users (Gear + Bureaucracy domains)  
