// LoopFollow
// OnboardingStep.swift

import Foundation

/// The phases of the first-run onboarding wizard.
///
/// Progress is tracked by phase, not by page: the set of phases is stable, while
/// some phases contain a variable number of internal pages (the Nightscout connect
/// phase can be one or two pages; the alarms phase is one page per offered alarm,
/// which differs between Nightscout and Dexcom). Those phases report their
/// within-phase position through `OnboardingViewModel.phaseProgress`, so the
/// overall progress bar stays smooth no matter how many pages a phase has.
///
/// `connect` renders the Nightscout, Dexcom, or import view depending on the data
/// source the user picks in `dataSource`.
enum OnboardingStep: CaseIterable, Hashable {
    case welcome
    case overview
    case dataSource
    case connect
    case units
    case generalAlarms
    case alarms
    case tabOrder
    case notifications
    case telemetry
    case completion

    /// Steps that show the progress bar + phase label + Skip at the top. The
    /// welcome and completion screens are full-bleed and provide their own CTA.
    var showsProgressHeader: Bool {
        switch self {
        case .welcome, .completion:
            return false
        default:
            return true
        }
    }

    /// Steps that use the shared Back / Continue footer. Phases that contain their
    /// own internal pages or custom primary buttons (overview, connect, units,
    /// alarms, notifications, telemetry) supply their own footer instead, as do the
    /// full-bleed welcome and completion screens.
    var usesSharedFooter: Bool {
        switch self {
        case .dataSource, .generalAlarms, .tabOrder:
            return true
        default:
            return false
        }
    }

    /// Short name shown in the progress header for this phase.
    var phaseTitle: String {
        switch self {
        case .welcome, .completion: return ""
        case .overview: return NSLocalizedString("Overview", comment: "Onboarding phase")
        case .dataSource: return NSLocalizedString("Data source", comment: "Onboarding phase")
        case .connect: return NSLocalizedString("Connect", comment: "Onboarding phase")
        case .units: return NSLocalizedString("Units & metrics", comment: "Onboarding phase")
        case .generalAlarms: return NSLocalizedString("Alarm basics", comment: "Onboarding phase")
        case .alarms: return NSLocalizedString("Alarms", comment: "Onboarding phase")
        case .tabOrder: return NSLocalizedString("Tabs", comment: "Onboarding phase")
        case .notifications: return NSLocalizedString("Notifications", comment: "Onboarding phase")
        case .telemetry: return NSLocalizedString("Privacy", comment: "Onboarding phase")
        }
    }
}
