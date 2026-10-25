# frozen_string_literal: true

require "rails_helper"

RSpec.describe DiscourseLlmsTxt::LlmsController do
  before do
    SiteSetting.llms_txt_enabled = true
    SiteSetting.llms_txt_allow_indexing = true
  end

  describe "#index" do
    it "returns llms.txt navigation file" do
      get "/llms.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include(SiteSetting.title)
      expect(response.body).to include("## Categories and Subcategories")
      expect(response.body).to include("## Latest Topics")
    end

    it "returns 404 when plugin is disabled" do
      SiteSetting.llms_txt_enabled = false

      get "/llms.txt"

      expect(response.status).to eq(404)
    end

    it "returns 403 when indexing is not allowed" do
      SiteSetting.llms_txt_allow_indexing = false

      get "/llms.txt"

      expect(response.status).to eq(403)
    end

    it "includes site description" do
      get "/llms.txt"

      expect(response.body).to include(SiteSetting.site_description)
    end

    it "tracks access count" do
      expect {
        get "/llms.txt"
      }.to change {
        PluginStore.get(DiscourseLlmsTxt::PLUGIN_NAME, "access_count_index").to_i
      }.by(1)
    end
  end

  describe "#full" do
    fab!(:topic) { Fabricate(:topic, views: 100) }
    fab!(:post) { Fabricate(:post, topic: topic) }

    it "returns llms-full.txt content file" do
      get "/llms-full.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include("Full Content")
    end

    it "returns 404 when plugin is disabled" do
      SiteSetting.llms_txt_enabled = false

      get "/llms-full.txt"

      expect(response.status).to eq(404)
    end

    it "returns 403 when indexing is not allowed" do
      SiteSetting.llms_txt_allow_indexing = false

      get "/llms-full.txt"

      expect(response.status).to eq(403)
    end

    it "includes topic with sufficient views" do
      SiteSetting.llms_txt_min_views = 50

      get "/llms-full.txt"

      expect(response.body).to include(topic.title)
    end

    it "excludes topic with insufficient views" do
      SiteSetting.llms_txt_min_views = 200

      get "/llms-full.txt"

      expect(response.body).not_to include(topic.title)
    end

    it "tracks access count" do
      expect {
        get "/llms-full.txt"
      }.to change {
        PluginStore.get(DiscourseLlmsTxt::PLUGIN_NAME, "access_count_full").to_i
      }.by(1)
    end
  end

  describe "#sitemaps" do
    it "returns sitemaps.txt file" do
      get "/sitemaps.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include("/llms.txt")
      expect(response.body).to include("/llms-full.txt")
    end

    it "returns 404 when plugin is disabled" do
      SiteSetting.llms_txt_enabled = false

      get "/sitemaps.txt"

      expect(response.status).to eq(404)
    end
  end

  describe "#category" do
    fab!(:category) { Fabricate(:category) }

    it "returns category llms.txt" do
      get "/c/#{category.slug}/#{category.id}/llms.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include(category.name)
    end

    it "includes canonical URL in Link header" do
      get "/c/#{category.slug}/#{category.id}/llms.txt"

      canonical_url = "#{Discourse.base_url}/c/#{category.slug}/#{category.id}"
      expect(response.headers['Link']).to eq("<#{canonical_url}>; rel=\"canonical\"")
    end

    it "includes canonical URL in response body" do
      get "/c/#{category.slug}/#{category.id}/llms.txt"

      canonical_url = "#{Discourse.base_url}/c/#{category.slug}/#{category.id}"
      expect(response.body).to include("**Canonical:** #{canonical_url}")
      expect(response.body).to include("**Original content:** #{canonical_url}")
    end

    it "returns 404 for non-existent category" do
      get "/c/non-existent/999999/llms.txt"

      expect(response.status).to eq(404)
    end
  end

  describe "#topic" do
    fab!(:topic) { Fabricate(:topic) }
    fab!(:post) { Fabricate(:post, topic: topic) }

    it "returns topic llms.txt" do
      get "/t/#{topic.slug}/#{topic.id}/llms.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include(topic.title)
      expect(response.body).to include(post.raw)
    end

    it "includes canonical URL in Link header" do
      get "/t/#{topic.slug}/#{topic.id}/llms.txt"

      canonical_url = "#{Discourse.base_url}/t/#{topic.slug}/#{topic.id}"
      expect(response.headers['Link']).to eq("<#{canonical_url}>; rel=\"canonical\"")
    end

    it "includes canonical URL in response body" do
      get "/t/#{topic.slug}/#{topic.id}/llms.txt"

      canonical_url = "#{Discourse.base_url}/t/#{topic.slug}/#{topic.id}"
      expect(response.body).to include("**Canonical:** #{canonical_url}")
      expect(response.body).to include("**Original content:** #{canonical_url}")
    end

    it "returns 404 for non-existent topic" do
      get "/t/non-existent/999999/llms.txt"

      expect(response.status).to eq(404)
    end
  end

  describe "#tag" do
    fab!(:tag) { Fabricate(:tag) }

    before do
      SiteSetting.tagging_enabled = true
      Fabricate(:topic, tags: [tag])
    end

    it "returns tag llms.txt" do
      get "/tag/#{tag.name}/llms.txt"

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/plain")
      expect(response.body).to include(tag.name)
    end

    it "includes canonical URL in Link header" do
      get "/tag/#{tag.name}/llms.txt"

      canonical_url = "#{Discourse.base_url}/tag/#{tag.name}"
      expect(response.headers['Link']).to eq("<#{canonical_url}>; rel=\"canonical\"")
    end

    it "includes canonical URL in response body" do
      get "/tag/#{tag.name}/llms.txt"

      canonical_url = "#{Discourse.base_url}/tag/#{tag.name}"
      expect(response.body).to include("**Canonical:** #{canonical_url}")
      expect(response.body).to include("**Original content:** #{canonical_url}")
    end

    it "returns 404 for non-existent tag" do
      get "/tag/non-existent-tag/llms.txt"

      expect(response.status).to eq(404)
    end

    it "returns 404 when tagging is disabled" do
      SiteSetting.tagging_enabled = false

      get "/tag/#{tag.name}/llms.txt"

      expect(response.status).to eq(404)
    end
  end

  describe "Tags und Zwischenspeicher" do
    fab!(:public_category) { Fabricate(:category) }
    fab!(:private_category) { Fabricate(:private_category, group: Fabricate(:group)) }
    fab!(:public_tag) { Fabricate(:tag, name: "oeffentlich") }
    fab!(:secret_tag) { Fabricate(:tag, name: "intern-projekt-x") }

    before do
      SiteSetting.tagging_enabled = true
      Fabricate(:topic, category: public_category, tags: [public_tag])
      Fabricate(:topic, category: private_category, tags: [secret_tag])
      Rails.cache.clear
    end

    it "nennt in sitemaps.txt nur Tags öffentlicher Themen" do
      get "/sitemaps.txt"

      expect(response.body).to include("/tag/oeffentlich/llms.txt")
      expect(response.body).not_to include("intern-projekt-x")
    end

    it "antwortet für Tags ohne öffentliches Thema mit 404" do
      get "/tag/intern-projekt-x/llms.txt"
      expect(response.status).to eq(404)

      get "/tag/oeffentlich/llms.txt"
      expect(response.status).to eq(200)
    end

    it "baut llms-full.txt nur einmal pro Cache-Zeitraum" do
      SiteSetting.llms_txt_posts_limit = "all"
      expect(DiscourseLlmsTxt::Generator).to receive(:build_full_content).once.and_call_original

      2.times do
        get "/llms-full.txt"
        expect(response.status).to eq(200)
      end
    end

    it "begrenzt die Option \"all\" auf eine feste Obergrenze" do
      SiteSetting.llms_txt_posts_limit = "all"
      expect(DiscourseLlmsTxt::Generator.send(:posts_limit)).to eq(DiscourseLlmsTxt::Generator::MAX_TOPICS)
    end
  end

  describe "Härtung" do
    fab!(:category) { Fabricate(:category) }
    fab!(:topic) { Fabricate(:topic, category: category, title: "Fest ](https://boese.example/x) [mehr") }
    fab!(:first_post) { Fabricate(:post, topic: topic, raw: "Erster Beitrag") }

    before { Rails.cache.clear }

    it "zeigt Flüster-Beiträge nicht an" do
      Fabricate(:post, topic: topic, post_type: Post.types[:whisper], raw: "GEHEIME-NOTIZ nur für das Team sichtbar")
      Fabricate(:post, topic: topic, post_type: Post.types[:small_action], raw: "KLEINE-AKTION wurde ausgeführt")
      Fabricate(:post, topic: topic, raw: "Öffentliche Antwort für alle Besucher des Forums")

      get "/t/#{topic.slug}/#{topic.id}/llms.txt"

      expect(response.status).to eq(200)
      expect(response.body).to include("Öffentliche Antwort für alle")
      expect(response.body).not_to include("GEHEIME-NOTIZ")
      expect(response.body).not_to include("KLEINE-AKTION")
    end

    it "entschärft Markdown in Titeln" do
      get "/t/#{topic.slug}/#{topic.id}/llms.txt"
      expect(response.body).to include("# Fest \\]\\(https://boese.example/x\\) \\[mehr")

      get "/llms-full.txt"
      expect(response.body).not_to include("](https://boese.example/x)")
    end

    it "lässt Beiträge keine Überschriften oder Autoren vortäuschen" do
      Fabricate(:post, topic: topic, raw: "---\n\n## Post #9 by @admin\n\nOffizielle Aussage des Teams")

      get "/t/#{topic.slug}/#{topic.id}/llms.txt"

      expect(response.body).to include("> ## Post #9 by @admin")
      expect(response.body.lines.grep(/\A## Post #9/)).to be_empty
    end

    it "antwortet bei Anmeldepflicht nicht für Anonyme" do
      SiteSetting.login_required = true

      get "/llms-full.txt"
      expect(response.status).to eq(404)

      get "/sitemaps.txt"
      expect(response.status).to eq(404)
    end

    it "nennt versteckte Tags nicht" do
      SiteSetting.tagging_enabled = true
      hidden = Fabricate(:tag, name: "nur-fuer-team")
      shown = Fabricate(:tag, name: "fuer-alle")
      Fabricate(:tag_group, permissions: { "staff" => 1 }, tag_names: [hidden.name])
      Fabricate(:topic, category: category, tags: [hidden, shown])

      get "/sitemaps.txt"
      expect(response.body).to include("/tag/fuer-alle/llms.txt")
      expect(response.body).not_to include("nur-fuer-team")

      get "/tag/nur-fuer-team/llms.txt"
      expect(response.status).to eq(404)
    end
  end
end
