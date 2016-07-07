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
        static let cmNewInvestCV               = "cmNewInvestCV"
        static let cmUserAddressTVC            = "cmUserAddressTVC"
        static let cmWebVC                     = "cmWebVC"
        static let cmProjectDetailVC           = "cmProjectDetailVC"
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
        static let cmProjectCommentCell        = "cmProjectCommentCell"
        static let imageLabelViewCell          = "imageLabelViewCell"
        //new project
        static let cmNameFieldCell             = "cmNameFieldCell"
        static let cmTextImageCell             = "cmTextImageCell"
        static let cmCVImageCell               = "cmCVImageCell"
        static let cmFourRadioBtnCell          = "cmFourRadioBtnCell"
        //项目管理
        static let cmProjectInvestCell         = "cmProjectInvestCell"
        static let cmProjectRewardCell         = "cmProjectRewardCell"
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
        static let cmProjectCommentCell        = "CMProjectCommentCell"
        static let imageLabelViewCell          = "ImageLabelViewCell"
        //new project 
        static let cmNameFieldCell             = "CMNameFieldCell"
        static let cmTextImageCell             = "CMTextImageCell"
        static let cmCVImageCell               = "CMCVImageCell"
        static let cmFourRadioBtnCell          = "CMFourRadioBtnCell"
        //项目管理
        static let cmProjectInvestCell         = "CMProjectInvestCell"
        static let cmProjectRewardCell         = "CMProjectRewardCell"
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
        
        //项目管理
        static let cmProjectManagerTVC          = "cmProjectManagerTVC"
        static let cmProjectManagerSupporterTVC = "cmProjectManagerSupporterTVC"
        static let cmProjectManagerRewardTVC    = "cmProjectManagerRewardTVC"
        static let cmProjectInvestDetailVC      = "cmProjectInvestDetailVC"
        
        //钱包
        static let cmWalletRechargeVC           = "cmWalletRechargeVC"
        static let cmWalletExchangeVC           = "cmWalletExchangeVC"
    }
}

struct NewProjectSB {
    static let step2MoneyTC        = "step2MoneyTC"
    static let step2PeopleTC       = "step2PeopleTC"
    static let step2GoodsTC        = "step2GoodsTC"
    static let step2PartnerTC      = "step2PartnerTC"
    
}


