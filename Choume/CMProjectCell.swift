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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
