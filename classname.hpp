#ifndef projectname_classname_H
#define projectname_classname_H

#include <boost/noncopyable.hpp>
#include <vizkit3d/Vizkit3DPlugin.hpp>
#include <osg/Geode>
#include <typeheader>

namespace vizkit3d
{
    class classname
        : public vizkit3d::Vizkit3DPlugin<typename>
        , boost::noncopyable
    {
    Q_OBJECT
    public:
        classname();
        ~classname();

    Q_INVOKABLE void updateData(typename const &sample)
    {vizkit3d::Vizkit3DPlugin<typename>::updateData(sample);}

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
