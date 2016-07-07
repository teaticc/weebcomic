class Scrabing
  # 一気に更新チェック
  def self.check_comics
      series_check = Comic.all
      #連載チェックフラグを一括オフ
      series_check.each do |comic|
        comic[:series] = false
      end
      jump_plus
      urasunday
      #連載終了を一括削除
      Comic.delete_all("series = false")
  end

  def self.jump_plus
    agent = Mechanize.new
    site = Site.find(1)
    top_page = agent.get(site.url)
    comic_info = top_page.search(site.info_tag)
    read_link = "http://plus.shonenjump.com/client_info/SHUEISHA/html/player/viewer.html?tw=2&lin=1&cid="
    comic_info.each do |info|
      comic = {}
      comic[:site_id] = 1
      comic[:title] = info.at("p.panel_title").inner_text
      comic[:author] = info.at("p.panel_author").inner_text
      comic[:thumbnail] = Site.find(1).url + info.at("img.panel_image")[:src]
      comic[:list_url] = info.at("a.panel_image_wrap")[:href]
      # html形式とビューアー形式でurlが異なる
      if info.at("span.content_id") == nil
        comic[:new_url] = info.at("span.url_link").inner_text
      else
        comic[:new_url] = read_link + info.at("span.content_id").inner_text
      end
      #文字列で更新日時を取得してからdate型へ変換
      update_str = info.at("p.panel_date").inner_text
      comic[:updated] = Time.strptime(update_str, "%Y年%m月%d日")
      comic[:weekday] = comic[:updated].wday
      comic[:series] = true
      if Comic.find_by(title: comic[:title]) == nil
        Comic.create(comic)
      else
        comic_record = Comic.find_by(title: comic[:title])
        comic_record.update(comic)
      end
    end
  end

  def self.urasunday
    agent = Mechanize.new
    site = Site.find(2)
    top_page = agent.get(site.url)
    comic_info = top_page.search(site.info_tag)
    comic_info.each do |info|
      comic = {}
      comic[:site_id] = 2
      link = info.at("a.indexMainImgLink")[:href]
      # linkの頭の.が邪魔なのでカット
      index_url = Site.find(2).url + link.slice(1,link.length)
      comic[:list_url] = index_url
      #作品ページを取得して再scrabing
      index_page = Mechanize.new.get(index_url)
      comic[:title] = index_page.at("h1").inner_text
      comic[:author] = index_page.at("h2").inner_text
      # binding.pry
      comic[:thumbnail] = index_page.at("body section div a img")[:src]
      new_link = index_page.at(".comicButtonBox a")[:href]
      #index_urlの/index.html/以前にnew_linkの先頭の.以降を結合
      index_url =~ /\/index.html/
      comic[:new_url] = $` + new_link.slice(1,new_link.length)
      # # index_url末尾のindex.html/を取り除き、new_link始めの.を除いて結合
      # comic[:new_url] = index_url.slice(0,index_url.length - "index.html/".length) + new_link.slice(1,new_link.length)
      update_str = index_page.at(".comicButtonBox").inner_text
      #正規表現で日付を検索
      update_str =~ /20..\/..\/../
      comic[:updated] = Time.parse($&)
      comic[:weekday] = comic[:updated].wday
      comic[:series] = true
      if Comic.find_by(title: comic[:title]) == nil
        Comic.create(comic)
      else
        comic_record = Comic.find_by(title: comic[:title])
        comic_record.update(comic)
      end
    end
  end


  ## 新サイト追加用テンプレート
  # def self.
  #   site_num =
  #   agent = Mechanize.new
  #   site = Site.find(site_num)
  #   top_page = agent.get(site.url)
  #   comic_info = top_page.search(site.info_tag)
  #   comic_info.each do |info|
  #     comic = {}
  #     comic[:site_id] = site_num
  #     comic[:list_url] =
  #     comic[:title] =
  #     comic[:author] =
  #     comic[:thumbnail] =
  #     update_str =
  #     comic[:updated] = Time.parse(update_str)
  #     comic[:weekday] = comic[:updated].wday
  #     comic[:series] = true
  #     if Comic.find_by(title: comic[:title]) == nil
  #       Comic.create(comic)
  #     else
  #       comic_record = Comic.find_by(title: comic[:title])
  #       comic_record.update(comic)
  #     end
  #   end
  # end


end
