# coding: utf-8
class City < ActiveRecord::Base
  if Rails.version < '4.0'
    attr_accessible :name, :province_id, :level, :zip_code, :pinyin, :pinyin_abbr
  end

  belongs_to :province
  has_many :districts, dependent: :destroy

  def short_name
    @short_name ||= name.gsub(/市|自治州|地区|特别行政区/,'')
  end

  def brothers
    @brothers ||= City.where("province_id = #{province_id}")
  end

  def self.get_province_cities
    @provinces = Province.find_by_sql("select provinces.id,provinces.name from provinces")
    @cities = Province.find_by_sql("select provinces.id as pid,provinces.name as pname,cities.id,cities.name from provinces left join cities on provinces.id = cities.province_id")
    arr = [];
    @provinces.each do |p|
      subarr = [];
      @cities.each do |c|
        if p.id == c.pid
          subarr.push({
          "id" => c.id.to_s,
          "text" => c.name,
          "value" => c.id.to_s,
          "showcheck" => true,
          "complete" => true,
          "isexpand" => false,
          "checkstate" => 0,
          "hasChildren" => false
          });
        end
      end
    arr.push({
    "id" => p.id.to_s,
    "text" => p.name,
    "value" => "province",
    "showcheck" => true,
    "complete" => true,
    "isexpand" => false,
    "checkstate" => 0,
    "hasChildren" => true,
    "ChildNodes" => subarr
    });
    end
    root = {
    "id" => "0",
    "text" => "全国",
    "value" => "0",
    "showcheck" => true,
    "complete" => true,
    "isexpand" => false,
    "checkstate" => 0,
    "hasChildren" => true,
    "ChildNodes" => arr
    };
  end

end
