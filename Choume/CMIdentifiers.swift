//
//  CMIdentifiers.swift
//  CM
//
//  Created by Augus on 10/5/15.
//  Copyright © 2015 iAugus. All rights reserved.
//

let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

struct MainStoryboard {

    struct VCIdentifiers {
        static let editVC                      = "iBBSEditingViewController"
        static let detailVC                    = "iBBSDetailViewController"
        static let nodeVC                      = "iBBSNodeViewController"
        //by wyp
        static let projectPreviewVC            = "projectPreviewVC"
        static let cmHelpDetailVC              = "cmHelpDetailVC"
        static let cmNewProjectVC              = "cmNewProjectVC"
        static let cmProjectReturnDetailVC     = "cmProjectReturnDetailVC"

    }

    struct CellIdentifiers {
        static let iBBSTableViewCell           = "iBBSTableViewCell"
        static let iBBSNodeTableViewCell       = "iBBSNodeTableViewCell"
        static let messageCell                 = "iBBSMessageTableViewCell"
        static let replyCell                   = "iBBSReplyCell"
        //by wyp
        static let userAddressCell             = "userAddressCell"
        static let cmProjectCell               = "cmProjectCell"
        static let joinProjectCell             = "joinProjectCell"
        static let imageLabelViewCell          = "imageLabelViewCell"
        //new project
        static let cmNameFieldCell             = "cmNameFieldCell"
    }

    struct CollectionCellIdentifiers {
        static let nodeCollectionCell          = "iBBSNodesCollectionViewCell"
    }

    struct NibIdentifiers {
        static let iBBSTableViewCell           = "CMTableViewCell"
        static let iBBSNodeTableViewCellName   = "IBBSNodeTableViewCell"
        static let replyCell                   = "IBBSReplyCell"
        static let headerView                  = "IBBSDetailHeaderView"
        static let messageCell                 = "IBBSMessageTableViewCell"
        static let themePickerView             = "IBBSThemePickerView"
        //by wyp
        static let userAddressCell             = "UserAddressCell"
        static let cmProjectCell               = "CMProjectCell"
        static let joinProjectCell             = "JoinProjectCell"
        static let imageLabelViewCell          = "ImageLabelViewCell"
        //new project 
        static let cmNameFieldCell             = "CMNameFieldCell"
    }

    struct SegueIdentifiers {
        static let postSegue                   = "postNewArticle"
        static let postNewArticleWithNodeSegue = "postNewArticleWithNode"
        static let nodeToMainVCSegueIdentifier = "nodeToMainVC"
        //by wyp
        static let toUserManageAddressSegue    = "manageAddress"
    }
}


struct SlidePanelStoryboard {
    
    struct VCIdentifiers {
        static let cmStartedVC     = "cmStartedVC"
        static let favoriteVC      = "iBBSFavoriteViewController"
        static let profileVC       = "iBBSProfileViewController"
        static let settingVC       = "iBBSSettingViewController"

        static let startedNav      = "startedProjectNavVC"
        static let involvedNav     = "involvedProjectNavVC"
        static let staredNav       = "staredNavVC"
        static let walletNav       = "walletNavVC"
        static let messageNav      = "messageNavVC"
        static let settingNav      = "settingNavVC"
        static let userInfoNav     = "myUserInfoNavgationController"
        static let userProfileVC   = "userProfileVC"
        //钱包充值
        static let cmWalletRechargeVC          = "cmWalletRechargeVC"
    }
}


