require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse file informations" do
    product = load_fixture("onix_ebook_with_files_example.xml")

    assert_equal 2, product.excerpt_infos.size
    e = product.excerpt_infos[0]

    assert_equal 2100230, e.file_size
    assert_equal "4b145ff46636b06f49225abdab70927f", e.md5
    assert_equal "epub_excerpt", e.file_type
    assert_equal Time.new(2012, 12, 30, 15, 18), e.updated_at
    assert_equal "https://www.elibri.com.pl/excerpt/767/4b145ff46636b06f49225abdab70927f/fragment.epub", e.link
    assert_equal 767, e.eid

    assert_equal 2, product.file_infos.size
    f = product.file_infos[0]
    assert_equal 4197382, f.file_size
    assert_equal "e9353ce40eaa677f8c5d666c2f8bbb3f", f.md5
    assert_equal "epub", f.file_type
    assert_equal Time.new(2012, 12, 30, 15, 18), f.updated_at
    assert_equal 765, f.eid
  end

end
