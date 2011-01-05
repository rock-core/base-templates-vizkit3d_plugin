#ifndef projectname_classname_H
#define projectname_classname_H

#include <boost/noncopyable.hpp>
#include <vizkit/VizPlugin.hpp>
#include <osg/Geode>

namespace vizkit
{
    class classname
        : public vizkit::VizPlugin<typename>
        , boost::noncopyable
    {
    public:
        classname();
        ~classname();

    protected:
        virtual osg::ref_ptr<osg::Node> createMainNode();
        virtual void updateMainNode(osg::Node* node);
        virtual void updateDataIntern(typename const& plan);
        
    private:
        struct Data;
        Data* p;
    };
}
#endif
