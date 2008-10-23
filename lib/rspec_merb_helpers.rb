module RSpecMerbHelpers
  def it_should_have_restful_routes(klass)
    controller = klass.to_s.underscore
    describe klass, "routes" do
      it "should be restful" do
        request_to("/#{controller}/5/edit").should == {
          :controller => controller,
          :action => 'edit',
          :id => '5',
          :format => nil
        }
      end
    end
  end

  def freeze_time!(t = Time.now)
    Time.stub!(:now).and_return(t)
  end

  def freeze_datetime!(t = DateTime.now)
    DateTime.stub!(:now).and_return(t)
  end

  def authenticated_request(login, method, url, parameters, &block)
    response = send(method, url, parameters) do |c|
      c.instance_variable_set(:@current_ma_user, User.first(:login => login))
      block.call(c) if block
    end
    response
  end

  def create_authenticated_requests(array)
    array.each do |name, login|
      [:get, :post, :put, :delete].each do |method|
        eval "
        def #{name}_#{method}(url, parameters = {}, &block)
          authenticated_request('#{login}', :#{method}, url, parameters, &block)
        end
        "
      end
    end
  end

  def it_should_have_fields(object_name, *fields)
    fields.each do |field|
      it "should have #{field}" do
        original_object = instance_variable_get(object_name)
        object = original_object.class.new(original_object.values.except(field))
        object.should_not be_valid
      end
    end
  end

  def it_should_have_created_at(object_name)
    it "should have created_at" do
      object = instance_variable_get(object_name)
      freeze_time!
      object.save
      object.created_at.should == Time.now
    end
  end

  def it_should_have_timestamps(object_name)
    it "should have timestamps" do
      object = instance_variable_get(object_name)
      freeze_time!
      created_at = Time.now
      object.save
      object.created_at.should == created_at
      object.updated_at.should == created_at

      freeze_time!(Time.now + 24.hours)
      object.save
      object.created_at.should == created_at
      object.updated_at.should == Time.now
    end
  end

  def it_should_be_valid(*object_names)
    object_names.each do |object_name|
      it "should be valid and save successfully" do
        object = instance_variable_get(object_name)
        object.should be_valid
        object.save
      end
    end
  end

end
