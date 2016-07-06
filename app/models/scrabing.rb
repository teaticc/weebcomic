class Scrabing
  def self.comics(site_id)
    agent = Mechanize.new
    # agent.user_agent_alias = "Mac Safari"# エージェント偽装
    site = Site.find(site_id)
    top_page = agent.get(site.url)
    comic_info = top_page.search(site.info_tag)
    #site_idごとに違う関数を呼び出す#もっと綺麗に書きたい
    if site_id == 1
      jump_plus(comic_info)
    elsif site_id == 2
      urasunday(comic_info)
    end
  end

  def self.jump_plus(comic_info)
    read_link = "http://plus.shonenjump.com/client_info/SHUEISHA/html/player/viewer.html?tw=2&lin=1&cid="
    comic_info.each do |info|
      comic = {}
      comic[:site_id] = 1
      comic[:title] = info.at("p.panel_title").inner_text
      comic[:author] = info.at("p.panel_author").inner_text
      comic[:thumbnail] = Site.find(1).url + info.at("img.panel_image")[:src]
      comic[:list_url] = info.at("a.panel_image_wrap")[:href]
      if info.at("span.content_id") == nil
        comic[:new_url] = info.at("span.url_link").inner_text
      else
        comic[:new_url] = read_link + info.at("span.content_id").inner_text
      end
      #文字列で更新日時を取得してからdate型へ変換
      update_str = info.at("p.panel_date").inner_text
      comic[:updated] = Time.strptime(update_str, "%Y年%m月%d日")
      if Comic.find_by(title: comic[:title]) == nil
        Comic.create(comic)
      else
        comic_record = Comic.find_by(title: comic[:title])
        comic_record.update(comic)
      end
    end
  end

  def self.urasunday(comic_info)
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
      if Comic.find_by(title: comic[:title]) == nil
        Comic.create(comic)
      else
        comic_record = Comic.find_by(title: comic[:title])
        comic_record.update(comic)
      end
    end
  end

end