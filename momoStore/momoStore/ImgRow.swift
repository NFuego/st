import Kingfisher
import UIKit
import Eureka

// ===================================================================================  new row & cell
struct Picture: Equatable {
    var url: String? // 1 of this
    var img: UIImage?
}
//
func ==(lhs: Picture, rhs: Picture) -> Bool {
    return lhs.url == rhs.url
}

final class ImgCell : Cell<Picture>,CellType {
    let img:UIImageView = UIImageView()
    let imgSize = 100
    let processor = RoundCornerImageProcessor(cornerRadius: 50)

    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(img)
        self.img.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(imgSize)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return 120 }
    }

    override func update() {
        guard let pic = row.value else { return }
        if let url = pic.url {
            self.img.kf.setImage(with: URL(string:url), options: [.transition(.fade(0.2)), .processor(processor)])
            self.img.kf.indicatorType = .activity
        }

        if let img = pic.img {
            self.img.image = img
        }
    }
}

final class ImgRow : Row<ImgCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ImgCell>()
    }
}
