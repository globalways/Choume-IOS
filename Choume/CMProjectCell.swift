import UIKit

class CMProjectCell: UITableViewCell {

    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectSubNameLabel: UILabel!
    @IBOutlet weak var projectProgress: UIProgressView!
    @IBOutlet weak var projectUserAvatar: CMAvatarImageView! {
        didSet{
            projectUserAvatar.backgroundColor = theme.CMNavBGColor.darkerColor(0.75)
            projectUserAvatar.image = AVATAR_PLACEHOLDER_IMAGE
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        projectProgress.progressTintColor = theme.CMNavBGColor
        projectImage.contentMode = .ScaleAspectFill
        projectImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProject(p:CfProject){
        projectNameLabel.text = p.title
        if p.pics.count > 0 {
            // 七牛缩放图片
            let resizeImage = p.pics[0].url! + "?imageView2/2/w/500"
            //let resizeImage = p.pics[0].url!
            //self.projectImage.sd_setImageWithURL(NSURL(string: resizeImage))
            self.projectImage.sd_setImageWithURL(NSURL(string: resizeImage), completed: { (image, error, sdImageCacheType, url) in
                //self.setPostedImage(image)
            })
        }
        projectSubNameLabel.text = p.desc
        projectProgress.progress = Float(Tool.projectProgressDouble(p))
        Tool.loadUserAvatarToView(p.hongId!, view: projectUserAvatar)
    }
    
    func setInvests(invest: CfProjectInvest) {
        projectNameLabel.text = invest.projectName
        let resizeImage = invest.projectPic + "?imageView2/2/w/500"
        self.projectImage.sd_setImageWithURL(NSURL(string: resizeImage))
        projectSubNameLabel.text = Tool.generateAbbr(invest)
        
        projectProgress.hidden   = true
        projectUserAvatar.hidden = true
    }

}
