require "rails_helper"

describe Fb::Exporter do
  describe ".post" do
    context "re_privates" do
      it "makes request to correct group with correct record" do
        rp = create(:re_private)
        id = ENV["FB_EZ_REPRIVATE_ID"]
        token = ENV["FB_EZ_REPRIVATE_TOKEN"]
        graph = double()
        stub_fb_request(id, token, rp.show_url)
        mock_graph(graph, id, token, rp.show_url)

        Fb::Exporter.post(rp)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: rp.show_url)
      end
    end

    context "jobs" do
      it "makes request to correct group with correct record" do
        job = create(:job)
        id = ENV["FB_EZ_JOB_ID"]
        token = ENV["FB_EZ_JOB_TOKEN"]
        graph = double()
        stub_fb_request(id, token, job.show_url)
        mock_graph(graph, id, token, job.show_url)

        Fb::Exporter.post(job)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: job.show_url)
      end
    end

    context "sales" do
      it "makes request to correct group with correct record" do
        sale = create(:sale)
        id = ENV["FB_EZ_SALE_ID"]
        token = ENV["FB_EZ_SALE_TOKEN"]
        graph = double()
        stub_fb_request(id, token, sale.show_url)
        mock_graph(graph, id, token, sale.show_url)

        Fb::Exporter.post(sale)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: sale.show_url)
      end
    end

    context "services" do
      it "makes request to correct group with correct record" do
        service = create(:service)
        id = ENV["FB_EZ_SERVICE_ID"]
        token = ENV["FB_EZ_SERVICE_TOKEN"]
        graph = double()
        stub_fb_request(id, token, service.show_url)
        mock_graph(graph, id, token, service.show_url)

        Fb::Exporter.post(service)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: service.show_url)
      end
    end

    context "answer" do
      it "makes request to correct group with correct record" do
        answer = create(:answer)
        id = ENV["FB_EZ_ANSWER_ID"]
        token = ENV["FB_EZ_ANSWER_TOKEN"]
        graph = double()
        stub_fb_request(id, token, answer.show_url)
        mock_graph(graph, id, token, answer.show_url)

        Fb::Exporter.post(answer)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: answer.show_url)
      end
    end

    context "post" do
      it "makes request to correct group with correct record" do
        post = create(:post)
        id = ENV["FB_EZ_POST_ID"]
        token = ENV["FB_EZ_POST_TOKEN"]
        graph = double()
        stub_fb_request(id, token, post.show_url)
        mock_graph(graph, id, token, post.show_url)

        Fb::Exporter.post(post)

        expect(graph)
          .to have_received(:put_connections)
          .with(id, "feed", link: post.show_url)
      end
    end
  end

  def stub_fb_request(id, token, link)
    stub_request(:post, "https://graph.facebook.com/#{id}/feed").
      with(body:  {"access_token": token, "link": link})
  end

  def mock_graph(graph, id, token, link)
    allow(Koala::Facebook::API).to receive(:new)
                               .with(token)
                               .and_return(graph)
    allow(graph).to receive(:put_connections)
                .with(id, "feed", link: link)
  end
end
