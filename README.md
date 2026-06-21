# TeslaTrek iOS

Native SwiftUI iOS app matching the exact Tesla Trek design system and screens from the reference assets.

## Design Fidelity
- Exact dark futuristic UI with neon blue (#00BFFF) + red accents
- Tesla Trek red lightning bolt logo
- Glowing ring range indicator, glowing route maps
- Tab bar: MAP • TRIPS • EXPLORE • PROFILE
- All key flows from the 10 reference screenshots:
  - Range dashboard + glowing map
  - Active navigation (turn-by-turn + END TRIP)
  - Trips list with Upcoming/Past + cards
  - Curated Trek detail with numbered checkpoints
  - XP reward / Level-up burst (confetti + unlocks)
  - Profile with Cybertruck + settings
  - Leaderboard + badges

## Run

1. Open the `TeslaTrek` folder in Xcode (macOS)
2. Create a new iOS App project named "TeslaTrek" (or drag the Swift files into an existing SwiftUI project)
3. Replace `ContentView.swift`, add the Models/, Views/, Components/ folders
4. Set minimum deployment to iOS 17.0+
5. Build & run on simulator or device

```bash
# From Mac terminal (example)
open -a Xcode
# Then File > New > Project > iOS App (SwiftUI)
```

## Structure
```
TeslaTrek/
├── TeslaTrekApp.swift
├── ContentView.swift          # Tab root + custom neon tab bar
├── DesignSystem.swift         # Colors, TTLogo, GlowingRing, NeonButton, TTCARD...
├── Models/
│   └── Models.swift
├── Views/
│   ├── MapHomeView.swift
│   ├── NavigationActiveView.swift
│   ├── TripsView.swift
│   ├── ExploreView.swift
│   └── ProfileView.swift
└── Components/
    ├── RewardModal.swift
    └── LeaderboardView.swift
```

## Data & State
All data is mock + in-memory for now. Replace `UserStore` / mock data with real backend (Tesla Fleet API, XYO, on-chain, Grok, etc.) as needed.

## Next Steps / Polish
- Real MapKit custom annotations + pulsing
- Live Tesla vehicle data + Plaid cashflow integration (see income-accelerator)
- Grok Assist chat sheet (⚡)
- Fortune cookie / treasure claiming <150m GPS
- On-chain voucher signing + Base mint flow
- Offline maps + caching
- Haptic + sound design for XP / level ups

Built to match the reference visuals pixel-perfect in spirit.

## Assets
Reference screenshots + video prototype live in:
`income-accelerator/tesla-trek/assets/teslatrek-ios/`

---

Tesla Trek — Turn every drive into a scored, on-chain adventure.
