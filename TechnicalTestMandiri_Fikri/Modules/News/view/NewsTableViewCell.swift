//
//  NewsTableViewCell.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var imageContent = UIImageView()
    var title = UILabel()
    var published = UILabel()
    var source = UILabel()
    var content = UILabel()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewConstraint() {
        title = UILabel(frame: CGRect(x: 30, y: 10, width: self.contentView.frame.size.width, height: 45))
        title.textColor = .black
        title.textAlignment = .left
        title.numberOfLines = 2
        title.font = .systemFont(ofSize: 16, weight: .bold)
        self.contentView.addSubview(title)
        
        imageContent = UIImageView(frame: CGRect(x: title.frame.origin.x, y: 60, width: title.frame.size.width + 40, height: 150))
        imageContent.backgroundColor = .clear
        imageContent.contentMode = .scaleToFill
        self.contentView.addSubview(imageContent)
        
        content = UILabel(frame: CGRect(x: imageContent.frame.origin.x, y: (imageContent.frame.maxY) - 25, width: imageContent.frame.size.width - 10, height: 150))
        content.textColor = .black
        content.font = .systemFont(ofSize: 14, weight: .regular)
        content.numberOfLines = 10
        content.textAlignment = .justified
        self.contentView.addSubview(content)
        
        source = UILabel(frame: CGRect(x: content.frame.origin.x, y: content.frame.maxY - 20, width: content.frame.size.width, height: 25))
        source.textColor = .gray
        source.font = .systemFont(ofSize: 12, weight: .light)
        self.contentView.addSubview(source)
        
        published = UILabel(frame: CGRect(x: source.frame.origin.x, y: source.frame.origin.y + 20, width: source.frame.size.width, height: 25))
        published.textColor = .gray
        published.font = .systemFont(ofSize: 12, weight: .light)
        self.contentView.addSubview(published)
    }
    
    func setContentData(data: ArticlesModule) {
        title.text = data.title
        if data.content != nil && data.content != "" {
            content.text = data.content
        }else {
            content.text = data.description
        }
        
        source.text = String(format: "Source: %@",data.source?.name ?? "")
        published.text = String(format: "Publish: %@", data.publishedAt ?? "")
        self.getLoadImageFromURL(dataArticles: data)
    }
    
    func getLoadImageFromURL(dataArticles: ArticlesModule) {
        KingfisherService.shared.loadImageFrom(urlString: dataArticles.urlToImage ?? "", success: { (data) in
            self.imageContent.image = ImageDataService.shared.convertToUIImage(from: data)
        }) { (data) in
            print("error hit \(data)")
        }
    }
    
}
