//
//  SettingsViewModel.swift
//  TagBoard
//
//  Created by Will Brandin on 4/1/20.
//  Copyright © 2020 Will Brandin. All rights reserved.
//

import UIKit

private enum SettingSection: Int, CaseIterable {
    case profile
    case prefix
    case share
    case logout
    
    var title: String? {
        switch self {
        case .profile: return "Profile"
        case .prefix: return "Prefix"
        case .share: return "Help Us Out"
        default: return nil
        }
    }
}

private enum ShareOption: Int, CaseIterable {
    case rate
    case feedback
    
    var title: String {
        switch self {
        case .rate: return "Rate the App"
        case .feedback: return "Send Feedback"
        }
    }
}

class SettingsViewModel {
    
    // MARK: - Properties
    
    var numberOfSections: Int {
        return SettingSection.allCases.count
    }
    
    // MARK: - Methods
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = SettingSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .share : return 2
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .prefix:
            let cell: PrefixTableViewCell = tableView.deqeueReusableCell(for: indexPath)
            cell.onSwitchChanged = self.handleSwitch
            return cell
            
        case .share:
            let shareOption = ShareOption.allCases[indexPath.row]
            let cell: CenteredSingleLineCell = tableView.deqeueReusableCell(for: indexPath)
            cell.setCell(title: shareOption.title, style: .standardStyle)
            return cell
            
        case .logout:
            let cell: CenteredSingleLineCell = tableView.deqeueReusableCell(for: indexPath)
            cell.setCell(title: "Log Out", style: .dangerStyle)
            return cell
            
        default:
            let cell: CenteredSingleLineCell = tableView.deqeueReusableCell(for: indexPath)
            cell.setCell(title: "CELL TITLE", style: .standardStyle)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = SettingSection(rawValue: section), let title = section.title else {
            return nil
        }
        
        let header: LargeTableViewHeader = tableView.deqeueReusableHeaderFooter()
        header.setCell(title: title)
        return header
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        guard let section = SettingSection(rawValue: section) else {
            return .leastNormalMagnitude
        }
        
        switch section {
        case .logout: return 36
        default: return 48
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSwitch(_ isOn: Bool) {
        print("Did Change to \(isOn ? "On" : "Off")")
    }
}

