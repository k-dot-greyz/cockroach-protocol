# Domain Ascent

**Per-domain prestige leaderboards.**

Domain Ascent is how users compare themselves to others _within a specific domain_ (Runway, Bureaucracy, Gear, etc.), not globally.

---

## Why Per-Domain?

**Single global leaderboard problems:**  
- Rewards jack-of-all-trades over domain mastery  
- Obscures who's actually good at what  
- Creates noise ("top scorer" could be mediocre in all domains)  

**Per-domain leaderboard benefits:**  
- Clear signal: "This person is a Bureaucracy expert"  
- Allows specialization and prestige in chosen domains  
- More interesting social dynamics (domain guilds, circles)  
- Easier to climb in a domain you care about  

---

## How It Works

### Domain Score

**Each domain has its own score**, calculated from:

1. **Node states** in that domain  
   - Dormant: 0 pts  
   - Active: 1 pt  
   - Secured: 10 pts  
   - Hardened: 30 pts  
   - Held: 50 pts  

2. **Objectives completed** in that domain  
   - Easy: +5 pts  
   - Medium: +10 pts  
   - Hard: +20 pts  

3. **Ladders** (disproportionate gains)  
   - Each ladder event: +20 pts  

4. **Hazards survived** without regression  
   - Hazard survived: +10 pts  

5. **Milestones**  
   - Full domain secured: +50 pts  
   - Full domain hardened: +150 pts  

---

## Example: Runway Domain Score

**User state:**  
- 1-month emergency fund: **Secured** (10 pts)  
- 3-month emergency fund: **Hardened** (30 pts)  
- High-yield savings: **Secured** (10 pts)  
- Income diversification: **Active** (1 pt)  
- Completed 5 Runway objectives (3 easy, 2 medium): 35 pts  
- Survived rent increase hazard: +10 pts  

**Total Runway Score: 96 pts**

---

## Leaderboard Structure

### Global View (Ascent Screen)

User sees **all 8 domain leaderboards** at once:

- Runway Ascent  
- Bureaucracy Ascent  
- Gear Ascent  
- Income Ascent  
- Digital Ascent  
- Network Ascent  
- Skills Ascent  
- Recovery Ascent  

Each leaderboard shows:

1. **User's rank** in that domain  
2. **Top 10 operators** in that domain (callsigns + scores)  
3. **Trend arrow** (rank movement: ↑ ↓ →)  
4. **Seasonal label** (e.g., "Q2 2026 HARDENING RUN")  

---

### Per-Domain View

User taps a domain to see:

- **Full leaderboard** (top 50 or 100)  
- **Rank emblems** (badges for top positions)  
- **Recent movers** (who climbed/dropped this week)  
- **Domain stats** (average score, median score, top score)  
- **Domain achievements** (special badges for domain mastery)  

---

## Rank Emblems

**Prestige indicators for top performers in each domain.**

### Runway Domain

- **Rank 1:** "Hardened Survivor" emblem  
- **Rank 2–5:** "Three-Month Creature" emblem  
- **Rank 6–10:** "Runway Builder" emblem  

### Bureaucracy Domain

- **Rank 1:** "Bureaucracy Eater" emblem  
- **Rank 2–5:** "Red-Tape Navigator" emblem  
- **Rank 6–10:** "Form Master" emblem  

_(Each domain has its own emblem set.)_

---

## Seasonal Runs

**Domain Ascent resets seasonally** (quarterly or annually).

**Why reset?**  
- Keeps competition fresh  
- Allows new operators to climb  
- Creates ceremonial moments (season-end rankings)  
- Preserves historical records ("Q1 2026 Runway Champion")  

**Seasonal rewards:**  
- Top 10 in a domain: permanent badge in profile  
- Season-end leaderboard screenshot (shareable)  
- Legacy emblem ("Q2 2026 Bureaucracy Master")  

---

## Social Layer

### Callsigns

**Users are identified by callsigns, not real names.**

**Examples:**  
- OPERATOR_7743  
- HARDENED_SWAN  
- RUNWAY_GHOST  
- BUREAUCRACY_CIPHER  

**Why callsigns?**  
- Privacy-first  
- Encrypted-cabal aesthetic  
- Reduces social comparison anxiety  
- Feels tactical, not performative  

### Circles

**Optional:** Users can form circles (private groups) within domains.

**Example:**  
- "Riga Runway Crew" (5 operators focusing on Runway hardening in Riga)  
- "Freelance Income Guild" (operators specializing in Income diversification)  

**Circle features:**  
- Private leaderboard (just your circle)  
- Shared objectives and protocols  
- Collaborative dead-drop routes  

---

## Leaderboard Visual Style

**Good style cues:**  
- Callsigns in mono font  
- Rank emblems (small, sharp icons)  
- Minimal row styling (dark background, subtle borders)  
- Trend arrows (↑ climbing, ↓ dropping, → stable)  
- Seasonal label at top ("Q2 2026 HARDENING RUN")  

**Avoid:**  
- Giant avatars  
- Confetti  
- Bright ribbons  
- Excessive crown/medal clutter  
- Mobile-app score energy  

**Think:** Encrypted cabal, not classroom sticker chart.

---

## Example: Runway Domain Ascent

```
RUNWAY ASCENT — Q2 2026 HARDENING RUN

 Rank  Callsign              Score   Trend
 ----  -------------------  ------  -----
  1    HARDENED_SWAN         2,340   ↑
  2    OPERATOR_7743         2,210   →
  3    RUNWAY_GHOST          2,180   ↓
  4    THREE_MONTH_CIPHER    1,950   ↑
  5    FRAGILITY_KILLER      1,890   →
 ...
 47    YOU (OPERATOR_4429)     820   ↑
```

**User sees:**  
- Current rank: 47  
- Score: 820 pts  
- Trend: ↑ (climbing)  
- Distance to next rank: 30 pts  

---

## Moderation and Fairness

**Potential issues:**  
1. **Score inflation** — Users gaming the system by marking nodes as Hardened without proof.  
2. **Fake objectives** — Users completing objectives without real-world action.  

**Solutions:**  
1. **Proof mechanisms** — QR/NFC scans, photo uploads, dead-drop verifications.  
2. **Peer review** — Circle members can flag suspicious activity.  
3. **Anomaly detection** — Sudden score jumps trigger review.  
4. **Manual review** — Top 10 operators subject to periodic verification.  

**Philosophy:**  
Domain Ascent is for **quiet operators**, not flex culture. Cheating defeats the purpose.

---

## Next Steps

1. Define Domain Ascent schema (JSON structure)  
2. Build leaderboard UI (per-domain and global views)  
3. Design rank emblems for each domain  
4. Define seasonal reset rules  
5. Implement proof mechanisms (QR, NFC, photo upload)  
