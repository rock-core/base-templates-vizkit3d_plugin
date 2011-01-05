#include "classname.hpp"

using namespace vizkit;

struct classname::Data {
    // Copy of the value given to updateDataIntern.
    //
    // Making a copy is required because of how OSG works
    typename data;
};


classname::classname()
    : p(new Data)
{
}

classname::~classname()
{
    delete p;
}

osg::ref_ptr<osg::Node> classname::createMainNode()
{
    // Geode is a common node used for vizkit plugins. It allows to display
    // "arbitrary" geometries
    return new osg::Geode();
}

void classname::updateMainNode ( osg::Node* node )
{
    osg::Geode* geode = static_cast<osg::Geode*>(node);
    // Update the main node using the data in p->data
}

void classname::updateDataIntern(typename const& value)
{
    p->data = value;
}

