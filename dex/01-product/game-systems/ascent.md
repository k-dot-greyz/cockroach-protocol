# Ascent

**The global progression tree.**

Ascent is how users unlock, secure, and harden capabilities across all domains.

---

## Core Concepts

### Nodes

A **node** is a discrete capability or asset.

**Examples:**  
- "Emergency fund (1 month)"  
- "Passport with 6+ months validity"  
- "Backup phone with active SIM"  
- "Benefits account registered"  

### Node States

1. **Dormant** — Node exists in the system, but user hasn't started it.  
2. **Active** — User is working on this node.  
3. **Secured** — Baseline capability achieved.  
4. **Hardened** — Resilience layer added.  
5. **Held** _(optional)_ — User is maintaining a hardened node over time.  

---

## Progression Flow

```
Dormant → Active → Secured → Hardened → Held
```

**Example: Emergency Fund Node**

- **Dormant:** Node visible in Runway domain, but not started.  
- **Active:** User adds "Build 1-month emergency fund" as objective.  
- **Secured:** User saves $3,000 (1 month of burn).  
- **Hardened:** User saves $9,000 (3 months of burn).  
- **Held:** User maintains $9,000+ over 6 months.  

---

## Unlock Conditions

Nodes can have **prerequisites** (dependencies).

**Example:**  
- **Node:** "Backup phone with active SIM"  
- **Prerequisite:** "Primary phone operational" (secured)  

**Example:**  
- **Node:** "6-month emergency fund"  
- **Prerequisite:** "1-month emergency fund" (secured)  

---

## Hardening Conditions

Hardening is the **resilience layer** beyond baseline capability.

**Hardening strategies:**  
1. **Redundancy** — Backup device, second income stream, alternate ID  
2. **Buffer** — Extra runway, spare gear, redundant credentials  
3. **Automation** — Auto-pay bills, scheduled transfers, dead-man switches  
4. **Documentation** — Protocols written down, checklists confirmed, emergency scripts prepared  

**Example:**  
- **Secured:** User has a passport.  
- **Hardened:** User has a passport _and_ a backup ID _and_ scanned copies in encrypted cloud storage.  

---

## Objectives

**Objectives** are actionable tasks that move nodes forward.

**Structure:**  
- **Title:** Short, clear action ("Open high-yield savings account")  
- **Domain:** Which domain does this belong to? (Runway, Bureaucracy, etc.)  
- **Node:** Which node does this advance? ("Emergency fund")  
- **Difficulty:** Easy, Medium, Hard  
- **Proof:** Optional — photo upload, QR scan, NFC tap  

**Example Objective:**  
**Title:** Open high-yield savings account  
**Domain:** Runway  
**Node:** Emergency fund (1 month)  
**Difficulty:** Easy  
**Proof:** Upload screenshot of account confirmation  

---

## Ladders and Hazards

**Progression is not linear.**

Inspired by Snakes & Ladders, but translated into elegant terminology:

### Ladders

**Disproportionate gains** that move you forward quickly.

**Examples:**  
- Fixed-rate refinance that cuts monthly burn by 15%  
- Second income lane activated (freelance contract signed)  
- 3-month runway milestone hit  
- Bureaucracy benefits unlocked (reduces monthly costs)  

**Effect:**  
- Jump multiple node states at once  
- Domain Ascent boost  
- Achievement unlock  

### Hazards

**Regressions and fragility events** that knock you back.

**Examples:**  
- Surprise repair ($800)  
- Client loss (income dip)  
- Medical bill  
- Account lock (bureaucracy hazard)  
- Rent increase  

**Effect:**  
- Node moves from Hardened → Secured or Secured → Active  
- Domain Ascent position drops  
- Threat Console alert triggered  

---

## Ascent Visualization

**Ascent Tree View** (HQ or dedicated Ascent screen)

- Vertical or branching route map  
- Each node represented as a badge, shard, or circuit point  
- Lines connect prerequisites  
- Color-coded by state:  
  - Gray: Dormant  
  - Blue: Active  
  - Green: Secured  
  - Teal: Hardened  
  - Gold: Held  

---

## Progression Logic Rules

1. **Capability first, hardening second, prestige third.**  
   - Unlock nodes by completing objectives  
   - Secure nodes to establish baseline capability  
   - Harden nodes to add resilience layer  
   - Climb Domain Ascent for prestige  

2. **Prerequisites must be Secured before dependent nodes unlock.**  
   - Example: "6-month runway" requires "1-month runway" (secured)  

3. **Hardening is optional but prestigious.**  
   - Users can operate with all nodes Secured and never harden  
   - But Domain Ascent rewards hardening significantly  

4. **Held state is rare and ceremonial.**  
   - Only appears after maintaining Hardened for extended period (3–6 months)  
   - Indicates deep resilience and discipline  

---

## Scoring (for Domain Ascent)

**Points by state:**  
- Dormant: 0 pts  
- Active: 1 pt  
- Secured: 10 pts  
- Hardened: 30 pts  
- Held: 50 pts  

**Bonuses:**  
- Ladder event: +20 pts  
- Hazard survived without regression: +10 pts  
- Full domain secured (all nodes secured): +50 pts  
- Full domain hardened (all nodes hardened): +150 pts  

**Domain Ascent = sum of all nodes in that domain.**

---
## Interaction with Domain Ascent

**Ascent** is the capability tree (what you can do).  
**Domain Ascent** is the prestige layer (how well you're doing compared to others in that domain).

**Example:**  
- User secures 8 Runway nodes → contributes to Runway Domain Ascent score  
- User hardens 3 Bureaucracy nodes → climbs Bureaucracy Domain Ascent leaderboard  

**Domain Ascent is per-domain**, not a single global leaderboard.

---

## Next Steps

1. Define node schemas (JSON structure)  
2. Seed initial nodes for Runway and Bureaucracy  
3. Map objectives to nodes  
4. Build Ascent tree visualization  
